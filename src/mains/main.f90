module ga_interface
use, non_intrinsic :: kinds, only: stdout, ik=>i32, rk=>sp
use, non_intrinsic :: constants, only: twopi=>twopi_sp
use, non_intrinsic :: util, only: covariance=>cov, cholesky_decomposition=>chol
use, non_intrinsic :: random, only: random_uniform=>random_uniform_sp
use, non_intrinsic :: selection, only: perform_selection=>selection_tournament
use, non_intrinsic :: crossover, only: perform_crossover=>crossover_fitness_weighted_gaussian_blend
use, non_intrinsic :: mutation, only: perform_mutation=>mutation_covariance_aware_gaussian
implicit none
private
public :: stdout, ik, rk
public :: twopi
public :: covariance, cholesky_decomposition, random_uniform
public :: perform_selection, perform_crossover, perform_mutation
end module ga_interface                                                           

module benchmark
use, non_intrinsic :: ga_interface
implicit none
private
public :: solve_rastrigin

contains
    
    pure subroutine rastrigin(x, fx)
        real(rk), intent(in) :: x(:,:)
        real(rk), intent(out) :: fx(:)
        integer :: i, xdim, nx
        xdim = size(x, dim=1)
        nx = size(x, dim=2)
        do concurrent (i=1:nx)
            fx(i) = 10.0_rk*xdim + sum(x(:,i)*x(:,i) - 10.0_rk*cos(twopi*x(:,i)), dim=1)
        end do
    end subroutine rastrigin

    impure subroutine solve_rastrigin(problem_dimension, population_size, maximum_generations)
        integer(ik), intent(in) :: problem_dimension, population_size, maximum_generations
        real(rk) :: fitness(population_size), cov(problem_dimension,problem_dimension), chol(problem_dimension,problem_dimension), &
                    baseline(problem_dimension,population_size*(maximum_generations+1)), baseline_fitness(size(baseline,dim=2))
        real(rk), target :: pop1(problem_dimension,population_size), pop2(problem_dimension,population_size)
        real(rk), pointer :: current_population(:,:), new_population(:,:), dummy_ptr(:,:)
        integer(ik) :: selected_pairs_ii(2,population_size-1), generation, elite_ii

        ! initialize population
        call random_uniform(pop1, size(pop1), -5.12, 5.12)
        current_population => pop1
        new_population => pop2

        ! calculate fitness
        call rastrigin(current_population, fitness)
        elite_ii = minloc(fitness, dim=1)
        write(stdout,'(a,f0.6)') 'initial best fitness: ',fitness(elite_ii)

        ! perform GA loop
        do generation=1,maximum_generations
            ! tournament selection, K=2
            call perform_selection(current_population, fitness, selected_pairs_ii, k_opt=2)

            ! fitness-weighted crossover with Gaussian blend
            call perform_crossover(current_population, selected_pairs_ii, fitness, new_population(:,1:population_size-1))
            new_population(:,population_size) = current_population(:,elite_ii)

            ! calculate covariance matrix and Cholesky factor for mutation
            call covariance(cov, new_population)
            call cholesky_decomposition(chol, cov)

            ! Gaussian mutation based on post-crossover population genetic covariance, mutation_rate=0.01
            call perform_mutation(new_population(:,1:population_size-1), 0.2, chol, sqrt(0.01*2*5.12))

            ! calculate fitness
            call rastrigin(new_population, fitness)
            elite_ii = minloc(fitness, dim=1)
            write(stdout,'(a,i0,a,f0.6)') 'generation: ',generation,', best fitness: ',fitness(elite_ii)

            ! swap population pointers
            dummy_ptr => current_population
            current_population => new_population
            new_population => dummy_ptr
        end do

        ! establish baseline
        call random_uniform(baseline, size(baseline), -5.12, 5.12)
        call rastrigin(baseline, baseline_fitness)
        elite_ii = minloc(baseline_fitness, dim=1)
        write(stdout,'(a,f0.6,a,i0,a)') 'baseline best fitness: ',baseline_fitness(elite_ii), &
                                        ' (',size(baseline_fitness),' evaluations)'
    end subroutine

end module benchmark

program main
use benchmark
implicit none

    call solve_rastrigin(20, 10, 2000)

end program main
