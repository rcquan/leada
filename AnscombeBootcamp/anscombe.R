#Constructing Vectors
vector_one <- c(1,2,3,4,5,6)
vector_one

vector_one[1]
vector_one[1:3] #grabs first three values
vector_one[0] #returns numeric(0)
vector_one[10] #returns NA

#Constructing Matrices
row_wise <- matrix(data=c(3,4,5,6,7,8,9), nrow=2, ncol=3, byrow = TRUE)
col_wise <- matrix(data=c(3,4,5,6,7,8,9), nrow=2, ncol=3, byrow = FALSE)
row_wise
col_wise
class(row_wise)
class(col_wise)

incomplete_matrix <- matrix(data=c(3,4,5,6,7,8), nrow=10, ncol=10, byrow =TRUE)
incomplete_matrix

#Constructing Data Frames
my_numbers = c(6,7,8)
my_strings = c("I", "Love", "Potatoes")
my_logicals = c(FALSE, FALSE, TRUE)
my_dataframe = data.frame(my_numbers, my_strings, my_logicals)
my_dataframe

names(my_dataframe) #access column names

#Accessing Matrix
test_matrix = matrix(c(1, 2, 3, 4, 5, 6), nrow=3, ncol=2) #let's first create the matrix
test_matrix

test_matrix[1,1] #returns value at row 1, column 1
test_matrix[1,10] #out of bounds
test_matrix[1,100] #out of bounds

test_matrix[2] #returns column index
test_matrix[2,] #returns 2nd row values as vector
test_matrix[,2] #returns 2nd col values as vector

#Accessing Data Frames
my_dataframe
my_dataframe$my_numbers[1] # returns value at position 1 of my_numbers col
my_dataframe[2,]

#Functions()
summary(my_dataframe$my_numbers) 

#plot()
x_to_plot = c(1,2,3)
y_to_plot = c(1,2,3)
plot(x_to_plot, y_to_plot, main = "first plot")

plot(y_to_plot ~ x_to_plot, main = "second plot")


