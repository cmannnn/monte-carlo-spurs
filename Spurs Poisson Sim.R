# import the dataset downloaded from github: https://github.com/gruffydd/monte-carlo-spurs/blob/main/Spurs%20Seasons.xlsx
# import dataset as spursbase


# Libraries
library(Runuran) #Monte Carlo
library(plotly) #Plotting interactive plots
library(dplyr) #Filter dataset


# create filtered datasets with each 5-season span
spurs9500<-filter(spursbase, startyear >= 1995 & startyear < 2000)
spurs0005<-filter(spursbase, startyear >= 2000 & startyear < 2005)
spurs0510<-filter(spursbase, startyear >= 2005 & startyear < 2010)
spurs1015<-filter(spursbase, startyear >= 2010 & startyear < 2015)
spurs1520<-filter(spursbase, startyear >= 2015 & startyear < 2020)


#  number of iterations
p <- 10000


# these next blocks of code run the simulation for each 5-season span
l9500 <- mean(spurs9500$pts)
sim9500 <- urpois(p,l9500,lb=0,ub=(38*3)); up=max(sim9500) #creates the Monte-Carlo Poisson simulation
summary(sim9500) #summary statistics

l0005 <- mean(spurs0005$pts)
sim0005 <- urpois(p,l0005,lb=0,ub=(38*3)); up=max(sim0005) #creates the Monte-Carlo Poisson simulation
summary(sim0005) #summary statistics

l0510 <- mean(spurs0510$pts)
sim0510 <- urpois(p,l0510,lb=0,ub=(38*3)); up=max(sim0510) #creates the Monte-Carlo Poisson simulation
summary(sim0510) #summary statistics

l1015 <- mean(spurs1015$pts)
sim1015 <- urpois(p,l1015,lb=0,ub=(38*3)); up=max(sim1015) #creates the Monte-Carlo Poisson simulation
summary(sim1015) #summary statistics

l1520 <- mean(spurs1520$pts)
sim1520 <- urpois(p,l1520,lb=0,ub=(38*3)); up=max(sim1520) #creates the Monte-Carlo Poisson simulation
summary(sim1520) #summary statistics


# turn simulations into data frames for plotting
simframe9500<-data.frame(sim9500)
simframe0005<-data.frame(sim0005)
simframe0510<-data.frame(sim0510)
simframe1015<-data.frame(sim1015)
simframe1520<-data.frame(sim1520)


# generate the figure
fig <- plot_ly(data=simframe9500, x=sim9500, type="histogram", color=I("purple"), name="95/96 - 99/00")
fig <- fig %>% add_histogram(data=simframe0005, x=sim0005, color=I("green4"), name="00/01 - 04/05")
fig <- fig %>% add_histogram(data=simframe0510, x=sim0510, color=I("yellow"), name="05/06 - 09/10")
fig <- fig %>% add_histogram(data=simframe1015, x=sim1015, color=I("green"), name="10/11 - 14/15")
fig <- fig %>% add_histogram(data=simframe1520, x=sim1520, color=I("blue4"), name="15/16 - 19/20")
fig <- fig %>% layout(barmode = "overlay")
f <- list(
  family = "Georgia",
  size = 18,
  color = "black"
)
x <- list(
  title = "Points",
  titlefont = f
)
y <- list(
  title = "Occurances",
  titlefont = f
)
fig <- fig %>% layout(xaxis =x,  yaxis =y)
fig
