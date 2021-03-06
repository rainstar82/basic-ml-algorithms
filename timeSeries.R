#install.packages("prophet")
library(prophet)
library(dplyr)

#Read, from Yahoo! Finance, the S&P 500 Index data for the last month
urlfile <- "http://chart.finance.yahoo.com/table.csv?s=^GSPC&a=1&b=28&c=2016&d=1&e=28&f=2017&g=d&ignore=.csv"
data <- read.csv(urlfile)

#Read the close price for the the S&P 500 Indes for the last month
cols <- c("Date", "Close")

#Create the data set needed to fit a model
spx_history <- data[,cols]
names(spx_history)[names(spx_history) == 'Date'] <- 'ds'
names(spx_history)[names(spx_history) == 'Close'] <- 'y'

#Fit a time-series model
model <- prophet(spx_history)

#Make a prediction
future <- make_future_dataframe(model, periods = 90)
forecast <- predict(model, future)
plot(model, forecast)
