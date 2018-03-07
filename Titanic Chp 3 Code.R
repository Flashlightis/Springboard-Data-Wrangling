install.packages("readxl")
library(readxl)
t2 <- read_excel("titanic_original.xlsx")

# 1. Find missing values in the embarked column and replace with "S"
t2$embarked[is.na(t2$embarked)] <- "S"

# 2. Populate misssing values in age column with average age
avg <- mean(t2$age, na.rm = TRUE)
t2$age[is.na(t2$age)] <- avg

# 3. Replace empty charachter strings in boat column with NA's
t2$boat[t2$boat ==""] <- NA

# 4. Create dummy variable column for missing cabin numbers
t2$cabin[t2$cabin == ""] <- NA
t2$has_cabin_number <- as.numeric(!is.na(t2$cabin))

# Submit the Project
write.csv(t2, "titanic_clean.csv")

install.packages("knitr")
library(knitr)
