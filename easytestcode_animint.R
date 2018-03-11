library("ggplot2")
library("animint")
devtools::install_github("faizan-khan-iit/ggplot2@5fb99d0cece13239bbbc09c6b8a7da7f86ac58e2")
devtools::install_github('rOpenSci/gistr')
library(animint)
library(dplyr)

pf<-read.csv("pseudo_facebook.tsv", sep = '\t')
pf <- pf[,-c(3,5,8, 9, 10, 11, 12, 13, 14, 15)]
pf <- subset(pf, pf$age<30 & pf$age>25 & !is.na(age) &!is.na(gender) & pf$tenure>500)

tenure_year <- pf$tenure/365
year_join <- 2014-tenure_year
year_join <- round(year_join, digits =0)
pf$year_joined <- year_join
pf$year_joined.bucket<- cut(pf$year_joined, breaks = c(2004,2009,2011,2012,2014))
pf$new <- with (pf, interaction(gender, year_joined.bucket))

p11 <- ggplot()+theme(legend.position="none")+geom_point(data=pf, aes(x=gender, y=year_joined, clickSelects=year_joined.bucket, color=year_joined.bucket), position = "jitter")
p12 <- ggplot()+geom_point(data=pf, aes(x=dob_year, y=age, clickSelect=year_joined.bucket, color=year_joined.bucket), position = "jitter")
plots_new <- list(plot1=p11, plot2=p12)

animint2gist(plots_new, description ="Year Joined vs Age Vs Gender in Pseudo Facebook Data")