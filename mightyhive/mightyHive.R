setwd("/Users/Quan/GitHub/leada/mightyhive/")

readData <- function(data){
        df <- read.csv(data, stringsAsFactors = FALSE)
        return(df)
}

# Exploration
aba <- readData("Abandoned_Data_Seed.csv")
head(aba)
tail(aba)
str(aba)

res <- readData("Reservation_Data_Seed.csv")
head(res)
tail(res)


length(which(aba$Incoming_Phone %in% res$Incoming_Phone))

length(which(aba$Contact_Phone %in% res$Contact_Phone))

test <- aba[which(aba$Contact_Phone %in% res$Contact_Phone), ]
