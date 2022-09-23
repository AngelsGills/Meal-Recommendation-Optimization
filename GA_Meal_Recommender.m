%{
___________________________________________________________________________
|                    Meal Recommender Optimization                        |
___________________________________________________________________________
%}
clc;
clear;

disp('--------------------WELCOME TO THE MEAL RECOMMENDER------------------');
% set food macronutrient targets, and read input file into class_table:
prompt = "Select calorie limit (grams):";
Calories = input(prompt);
prompt = "Select protein limit (grams):";							
Protein = input(prompt);
prompt = "Select carb limit (grams):";
Carbs = input(prompt);
prompt = "Select fat limit (grams):";
Fat = input(prompt);
items_file = 'Recipes@.csv';					                % initialize variable to string name of file
meal_table =  readtable(items_file);				                % read file
% Define limits for each meal type:
mealTypes = {'Breakfast','Entrée','Protein','Side','Soup'};		    	% MealTypes
global a
a = [];
prompt = "Do you want to include breakfast meals? Y/N";
txt = limit(prompt);
prompt = "Do you want to include entrée meals? Y/N";
txt = limit(prompt);
prompt = "Do you want to include protein meals? Y/N";
txt = limit(prompt);
prompt = "Do you want to include side meals? Y/N";
txt = limit(prompt);
prompt = "Do you want to include soup meals? Y/N";
txt = limit(prompt);
mealLimits = a;		                	                            	% number of each mealType allowed (i.e., max) 
mealMap = containers.Map(mealTypes,mealLimits);		                	% mealMap equals a map of mealTypes and mealLimits
% define chromosome and fitness function:
chromosome_length = height(meal_table);			                    	% chromo_len based on rows of table
fit_func = @(chromosome)-(chromosome * ones(chromosome_length,1));		% fit_func considering credits of meal_table
% defined masks based on class_table:
category_index_map = containers.Map();				                % creates a category_index_map map
	for i = 1:height(meal_table)				                % i to height of meal_table
	MealType = meal_table.Meal{i};			                        % MealType = MealType{i}
		if isKey(category_index_map,MealType)		                % iskey(map, MealTye{i}
		indices = category_index_map(MealType);	                    	% indices = map(MealType)
		indices = horzcat(indices, i);			                % indices = MealType concatenated horizontally with i
		category_index_map(MealType) = indices;	                    	% .._map = indices defined above ^
		else
		category_index_map(MealType) = [i];		                %.._map(MealType) = i
		end
	end
noof_categories = size(category_index_map,1);			            	% get columns
masks = zeros(noof_categories,height(meal_table));		            	% masks of zeros for col and row of table
keySet = keys(category_index_map);				                % create cell array cotaining its keys for map
for i = 1:noof_categories					                % i to noof_cat
	indices = category_index_map(keySet{i});		                % indices = keySet{i}
	for j = 1:length(indices)				                % 1 to length of indices
		masks(i,indices(j)) = 1;			                % sets mask to integer 1, indicating seperate categories
	end
end
% define A, b, Lb, Ub, and int_indices:
% concatenate vertically ineq parameters and masks
A = vertcat(meal_table.Calories',meal_table.Protein',meal_table.Carbs',meal_table.Fat', masks);				
b = [Calories, Protein, Carbs, Fat, mealLimits];				% ineq parameters for constraint
Lb = zeros(1,chromosome_length);                                    		% lower/upper/indice bounds for length of chromosome
Ub = ones(1,chromosome_length);                                     
int_indices = 1:chromosome_length;
% run ga:
disp('-----------------------------GA STARTING-----------------------------');
options = optimoptions('ga','display','off');
selection = ga(fit_func,chromosome_length,A,b,...                   		% selection of ga based on fitness function, chromosome length,
[],[],Lb,Ub,[],int_indices);                                        		% constaints, linear constrains, bounds, nonlinear constraints, % indices
disp('-----------------------------GA Finished-----------------------------');
% display results:
message = sprintf('OPTIMAL SELECTION OF ITEMS:');
for i = 1:chromosome_length
    if selection(i) == 1
        % pull url link from csv to be displayed as a link on matlab
        link = string(meal_table.URL(i));
        quote = '"';
        linkwithquote = quote + link + quote;
        charlink = char(linkwithquote);
        url = "This is a link to the <a href=";
        urllink = ">Recipe</a>.";
        x = strcat(url, charlink, urllink);
        g = "g";
        % display meals and appropriate link to recipe
        message = sprintf('%s \n%s - %s - %s %s%s, %s %s%s, %s %s%s, %s %s%s, %s ', message,... 
            string(meal_table.Meal(i)), string(meal_table.RecipeName(i)),...
            "Cal:",string(meal_table.Calories(i)), g,...
            "Protein:", string(meal_table.Protein(i)), g,...
            "Carbs:", string(meal_table.Carbs(i)), g,...
            "Fat:", string(meal_table.Fat(i)), g, string(x));
    end
end
% display total macronutrients of selected meals
fprintf('%s \n', message);
fprintf('Total Calories (grams): %d\n', selection * meal_table.Calories);
fprintf('Total Protein (grams): %d\n', selection * meal_table.Protein);
fprintf('Total Carbs (grams): %d\n', selection * meal_table.Carbs);
fprintf('Total Fat (grams): %d\n', selection * meal_table.Fat);
disp('---------------------------ENJOY THE MEALS---------------------------');
% function for meal limit
function txt = limit(prompt)
    global a
    txt = input(prompt,"s");
    if txt == 'Y'
        prompt = "Enter number for meal limit:";
        a(end+1) = input(prompt);
    else 
        a(end+1) = 0;
    end
end
