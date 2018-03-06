install.packages("readxl")
library(readxl)

df <- read_excel("refine_original.xlsx")

install.packages("dplyr")
library(dplyr)

install.packages("tidyr")
library(tidyr)

#1 - Clean up brand names
df$company <- sapply(df$company, tolower)
tail(df$company, n=15)
df$company <- gsub(".*ps", "phillips", df$company)
df$company <- gsub("^a.*", "akzo", df$company)
df$company <- gsub("^u.*", "unilever", df$company)

#2 - Seperate Product Code & Number
df <- separate(df, "Product code / number", c("product_code", "product_number"))

#3 - Add Product Categories
df$product_category <- df$product_code
df$product_category <- gsub("p", "Smartphone", df$product_category)
df$product_category <- gsub("v", "TV", df$product_category)
df$product_category <- gsub("x", "Laptop", df$product_category)
df$product_category <- gsub("q", "Tablet", df$product_category)

#3b - re-arranged columns so it made more sense
df <- df[c("company", "product_code", "product_category", "product_number", "address", "city", "country", "name")]

#4 - Add Full Address for Geocoding
df$full_address <- paste(df$address, df$city, df$country, sep = ",")

#5 - Create Dummy Variables For Company & Product Category
#Companies
df["company_phillips"] <- NA
df$company_phillips[df$company == "phillips"] = 1
df$company_phillips[df$company != "phillips"] = 0
df["company_akzo"] <- NA
df$company_akzo[df$company == "akzo"] = 1
df$company_akzo[df$company != "akzo"] = 0
df["company_van_houten"] <- NA
df$company_van_houten[df$company == "van houten"] = 1
df$company_van_houten[df$company != "van houten"] = 0
df["company_unilever"] <- NA
df$company_unilever[df$company == "unilever"] = 1
df$company_unilever[df$company != "unilever"] = 0
#Category
df["product_smartphone"] <- NA
df$product_smartphone[df$product_category == "Smartphone"] = 1
df$product_smartphone[df$product_category != "Smartphone"] = 0
df["product_tv"] <- NA
df$product_tv[df$product_category == "TV"] = 1
df$product_tv[df$product_category != "TV"] = 0
df["product_laptop"] <- NA
df$product_laptop[df$product_category == "Laptop"] = 1
df$product_laptop[df$product_category != "Laptop"] = 0
df["product_tablet"] <- NA
df$product_tv[df$product_category == "Tablet"] = 1
df$product_tv[df$product_category != "Tablet"] = 0

write.csv(df, "refine_clean.csv")


