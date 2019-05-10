# game_theory_Euler
## main_code
C code for running spatial/non-spatial simulations.

- To compile, ``gcc game_theory.c -lm -O3 -o game_theory.out``  
then ``./game_theory.out 1`` to execute the simulation.  
The first argument is the seed for random number generator and is required.

- To change simulation parameters, edit ``input.dat``. The order of parameters are specified on the second line.

- ``create_fd.py`` helps create a batch of folders for different A0's systematically.

- To switch spatial/non-spatial, edit line 8 in ``header.h``.  
``#define spatial 1`` for spatial simulations, ``#define spatial 0`` for non-spatial simulations.  
After save the changes in ``header.h``, recompile and run simulations.

- ``fxs_pbc.c`` constains most sub-routines specific to environment-depedent games, including randomly drawing players in a game,
calculate environment-dependent payoffs, calculate change in environment using the Euler method, 2D diffusion, etc.

- ``innout.c``, ``rand.c``, ``initialization.c``, ``alloc.c`` are general helper functions handling random number generator,
file I/O, and array allocation.

- The folder ``outfile`` is for storage of simulation data. Make sure to have such a folder before running simulations,
otherwise ``segmentation fault`` will occur.

## data_collection
MATLAB scripts to collect simulation data and store as ``.mat`` file in batch for future analysis and visualization.

## gr_calculation
MATLAB scripts to calculate pair correlation of spatial profiles.

## script_for_figs
MATLAB scripts for plotting figures in the paper [Spatial Interactions and Oscillatory Tragedies of the Commons](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.122.148102).
