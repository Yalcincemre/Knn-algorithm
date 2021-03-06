#**Gerekli K�t�phaneler**

library("class")
library("ggplot2")
library("png")
library("grid")

attach(iris)

# Veri Seti 

#Veri k�mesi, her biri bir t�r iris bitkisine at�fta bulunan 50 �rneklik 3 s�n�f i�erir.
#Yan�t de�i�keni: iris bitkisinin s�n�f�.
#1. sepal length (�anak yaprak uzunlu�u) in cm 
#2. sepal width (�anak yaprak geni�li�i) in cm 
#3. petal length (ta� yaprak uzunlu�u) in cm 
#4. petal width (ta� yaprak geni�li�i) in cm 
#5. class: Iris Setosa- Iris Versicolour- Iris Virginica

summary(iris)
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

# Veri Seti G�rselle�tirmesi

ggplot(data = iris,aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + geom_point()

# Train-Test Ayr�m�

smp_size <- floor(0.6 * nrow(iris))
set.seed(123) 
train_ind <- sample(nrow(iris), size = smp_size, replace = FALSE)
train <- iris[train_ind, ]
test <- iris[-train_ind, ]

# Optimum k de�erini bulmak i�in train verisindeki g�zlem say�s�n�n karek�k� hesaplan�r.

sqrt(90)

iris_pred2 <- knn(train = train[,1:4], test = test[,1:4], cl = train[,5], k=9)
iris_pred3 <- knn(train = train[,1:4], test = test[,1:4], cl = train[,5], k=15)
iris_pred4 <- knn(train = train[,1:4], test = test[,1:4], cl = train[,5], k=25)

#Algoritma kurulurken optimum k de�erine yak�n olan de�erden ba�layarak k artt�r�lm��t�r.

# Confusion Matrix 

cm2 <- table(test$Species, iris_pred2) 
cm2 

#Algoritmada k=9 al�nd���nda, 

cm3 <- table(test$Species, iris_pred3) 
cm3 

#Algoritmada k=15 al�nd���nda, 

cm4 <- table(test$Species, iris_pred4) 
cm4 

#Algoritmada k=25 al�nd���nda, 

misClassError2 <- mean(iris_pred2 != test$Species) 
misClassError3 <- mean(iris_pred3 != test$Species) 
misClassError4 <- mean(iris_pred4 != test$Species) 

Accuracy2=1-misClassError2
Accuracy3=1-misClassError3
Accuracy4=1-misClassError4

cbind(Accuracy2,Accuracy3,Accuracy4)

#Algoritmada k=9 al�nd���nda, %95 do�ruluk elde edilmi�tir.
#Algoritmada k=9 al�nd���nda, %93.3 do�ruluk elde edilmi�tir.
#Algoritmada k=9 al�nd���nda, %91.7 do�ruluk elde edilmi�tir.
#Optimum k de�erinden uzakla�t�k�a accuracy de�erinin d��t��� g�zlemlenmi�tir.


