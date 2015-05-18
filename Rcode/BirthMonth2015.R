library(ggplot2)
require(scales)
library(ggthemes)

setwd("E:\\Hockey\\WHL\\Age")

df <- read.csv("data\\WhlDraft2015.csv")
str(df)

df$DOB <- as.Date(df$DOB, format = "%m/%d/%Y")
df$month <- format(df$DOB, "%b")
df$Month <- factor(df$month, levels=c("Jan", "Feb","Mar",
                "Apr", "May", "Jun", "Jul", "Aug", "Sep",
                "Oct", "Nov", "Dec"))

df <- df[!is.na(df$Wt),]
df <- df[!is.na(df$Month),]

table(df$Month)

df$average <- (dim(df)[1])/12
df$PercentAverage <- 1/12

p1 <- ggplot(df, aes(factor(df$Month))) + geom_bar()+ 
        ylab("Count of Players Drafted") + xlab("Birth Month") + 
        ggtitle("2015 WHL Bantam Draft (Average = 19)") + 
        theme(plot.title = element_text(vjust = 1)) +
        theme_economist() + 
        geom_hline(y=19, size = 2, color = "red", alpha = 0.3) +
        stat_bin(binwidth=1, geom="text", aes(label=..count..), vjust=1.5, color = "white") + 
        theme(axis.text=element_text(size=11),
              axis.title=element_text(size=12))

png("Output//WHL Bantam Draft By Month.png")
p1
dev.off()









