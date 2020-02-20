#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(reshape2)


# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("Investing Modalities"),
    # Sidebar with a slider input for number of bins 
    fluidRow(column(3,
                         sliderInput("amt","Inital Amount:",min = 1,max = 10000,value = 1000,step = 100),
                         sliderInput("cont","Amount contributed:",min=1,max=5000,value = 200,step = 100),
                         sliderInput("growth","Annual Growth Rate(in %):",min=0,max=20, value =.2,step = .01)
    ),
    column(3,
                         sliderInput("rate","High Yield Rate:", min = 0, max = 20,value = .2,step = .01),
                         sliderInput("fix","Fixed Income rate:",min=0,max=20,value = .05, step= .1),
                         sliderInput("us","U.S Equality Rate(in %):",min=0,max=20,value =.10,step = .01)
    ),
    column(3,
                         sliderInput("vol","High Yield Votality:",min = 0,max = 20,value = 0.1,step = .1),
                         sliderInput("fixvol","Fixed Income Votality:",min=0,max=20,value = 4.5,step = .01),
                         sliderInput("usvol","U.S Equality Votality(in %):",min=0,max=20,value =15,step=.01)
    ),
    column(3,
                         sliderInput("years","Years:",min = 1,max = 50,value = 20,step = 1),
                         numericInput("seed","Random seed:",value = 12345),
                         selectInput("facet","Facet?:",c('Yes','No')))),
    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("modaility")
    )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
    output$modaility <- renderPlot({
#' Title: future_value()
#' Description: formula used in finance to calculate the value of a cash flow at a later date than originally received.
#' Param: payment: Cash flows at a period 1, growth: rate of growht, periods: number of years
#' Return: Produces a cash amount
        
        payment=input$cont
        growth=input$growth
        periods=input$years
        future_value=function(payment,growth,periods){
            # computes a cash value at a later date based on the 3 param
            x=payment*(1+growth)^(periods-1)
            return(x)
        }

# fills in the value of high_yield vector using a for loop to genrate the cash values
        rate_yield=input$rate
        vol_yield=input$vol
        set.seed(input$seed) # seed value 12345
        
        
        amt<- input$amt
        high_yield=rep(0,periods)
        for (i in 1:periods) {
            if( i == 1) {
                high_yield[i] = amt
            } else {
                r_bonds=rnorm(1,rate_yield/100,vol_yield/100)
                amt=amt*(1+r_bonds)+future_value(payment,growth,periods)
                high_yield[i] = amt
            }
        }

# fills in the values of us_bonds vector using a for loop to genrate the cash values
        rate_bonds=input$fix
        vol_bonds=input$fixvol
        amt<- input$amt

        
        us_bonds=rep(0,periods)
        for (i in 1:periods) {
            if( i == 1) {
                us_bonds[i] = amt
            } else {
                r_bonds=rnorm(1,rate_bonds/100,vol_bonds/100)
                amt=amt*(1+r_bonds)+future_value(payment,growth,periods)
                us_bonds[i] = amt
            }
        }

# fills in the values of the us_stocks vector using a for loop to genrate the cash values
    
    rate_stock=input$us
    stock_vol=input$usvol
    amt<- input$amt

    us_stocks=rep(0,periods)
    for (i in 1:periods) {
        if( i == 1) {
            us_stocks[i] = amt
        } else {
            r_bonds=rnorm(1,rate_stock/100,stock_vol/100)
            amt=amt*(1+r_bonds)+future_value(payment,growth,periods)
            us_stocks[i] =amt
        }
    }
    
#creates a data frame that contains the number of years and the values of the three vectors defined above
modaility=data.frame(year = 1:periods,high_yield,us_bonds,us_stocks)

# creates a column based on the function values
amount=c(high_yield,us_bonds,us_stocks)

# creates a column with the types and repeats based on the value of each function
types=c(rep("high_yield", periods),rep("us_bonds", periods),rep("us_stocks", periods))

# Creates a data frame for the facet graph
facet_data=data.frame(year = 1:periods,amount,types)

# Facets depending on the condition
    if(input$facet=="Yes")
        {ggplot(data = facet_data)+geom_area(aes(x=year, y=amount,fill=types,alpha=.5))+geom_point(aes(x=year,y=amount,fill=types))+
            geom_line(aes(x=year,y=amount, color=types))+facet_grid(~types)+
            xlab("year")+ylab('amount')+ggtitle('Timelines',"Three Indices")+scale_fill_discrete(name = "Index")
        } else {
            ggplot(data=modaility)+
                geom_line(aes(x=year,y=high_yield,color="high_yield"))+
                geom_line(aes(x=year,y=us_bonds,color="us_bonds"))+
                geom_line((aes(x=year,y=us_stocks,color='us_stock')))+
                geom_point(aes(x=year,y=high_yield,color="high_yield"))+
                geom_point(aes(x=year,y=us_bonds,color="us_bonds"))+
                geom_point(aes(x=year,y=us_stocks,color="us_stock"))+
                xlab("year")+ylab('amount')+ggtitle('Timelines',"Three Indices")+scale_fill_discrete(name = "Index ")
            }
        })
}

# Run the application 
shinyApp(ui = ui, server = server)

