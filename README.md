# Meal-Recommendation-Optimization
Implementing a genetic algorithm for an optimized selection of specified macronutrient meals.

The project consists of implementing a genetic algorithm to recommend meals based on the three significant types of macronutrients: proteins, carbohydrates, and fats. The body needs these nutrients in larger amounts in order to function properly in addition to other vital nutrients such as water, vitamins, and minerals. In addition, all of these nutrients provide your body with energy measured in the form of calories, the focus of the algorithm will be towards macro rich meals as the base of a diet. Provided is a recipes file to be read by the program which contains meal information such as meal types, calories, macros, and URL links with information to each meal. The links provide a recipe for the meal, list of ingredients, nutrients, and meal preparation instructions. 

A genetic algorithm (GA) is a method for solving both constrained and unconstrained optimization problems based on a natural selection process that mimics biological evolution. The algorithm repeatedly modifies a population of individual solutions. At each step, the genetic algorithm randomly selects individuals from the current population and uses them as parents to produce the children for the next generation. Over successive generations, the population "evolves" toward an optimal solution.

The following outline summarizes how the genetic algorithm works:
1. The algorithm begins by creating a random initial population.
2. The algorithm then creates a sequence of new populations. At each step, the algorithm uses the individuals in the current generation to create the next population. To create the new population, the algorithm performs the following steps:
a) Scores each member of the current population by computing its fitness value. These values are called the raw fitness scores.
b) Scales the raw fitness scores to convert them into a more usable range of values. These scaled values are called expectation values.
c) Selects members, called parents, based on their expectation.
d) Some of the individuals in the current population that have lower fitness are chosen as elite. These elite individuals are passed to the next population.
e) Produces children from the parents. Children are produced either by making random changes to a single parent—mutation—or by combining the vector entries of a pair of parents—crossover.
f) Replaces the current population with the children to form the next generation.
3. The algorithm stops when one of the stopping criteria is met. See Stopping Conditions for the Algorithm.
4. The algorithm takes modified steps for linear and integer constraints. See Integer and Linear Constraints.
5. The algorithm is further modified for nonlinear constraints.

When executing the program, the user can set target goals/limits (calories, proteins, carbs, and fats) for the recommended meals. The user also has the option to either include or exclude meal types, this feature was implemented to accommodate unique dietary meal type preferences. By choosing to include a specific meal type, the program allows the user to enter numeric limit of meals for that specific meal type. Once the genetic algorithm has reached an optimal solution, the selection of meals is displayed to the user with the meal's appropriate information (meal type, macros, recipe URL link). Lastly, the macronutrients of the combined meals are displayed to the user.  

It is important to note that genetic algorithms are non-deterministic in method. Thus, the solutions they provide may vary each time you run the algorithm in the same instance. The quality of the results depends highly on: the initial population, genetic operators (crossover, selection, mutation), and probabilities of crossover & mutation. For this project, the implementation of a genetic algorithm aims to recommend a selection of meals that aims to fill the dietary requirements set by the user. Thus, the non-deterministic algorithm can provide different meal recommendations that will aim to fulfill the user's macro targets (which is a terrific way to incorporate new foods into your diet). 
