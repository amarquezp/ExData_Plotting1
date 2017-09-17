library(grDevices)

plot1<-function(){
	
	HOUSEHOLD_POWER_CONSUMPTION_FILE <- "data/household_power_consumption.txt"
	HEADERS_NAMES <- c('DATE', 'TIME', 'GLOBAL_ACTIVE_POWER','GLOBAL_REACTIVE_POWER', 'VOLTAGE','GLOBAL_INTENSITY','SUB_MET1', 'SUB_MET2', 'SUB_MET3')
	
	powerConsumptionDT <- read.table(file=HOUSEHOLD_POWER_CONSUMPTION_FILE,sep = ';', header = TRUE, skip = 66636, nrows=2880, na.strings = '?' )
	names(powerConsumptionDT)<- HEADERS_NAMES
	
	powerConsumptionDT$DATE	<- as.Date(powerConsumptionDT$DATE, '%d/%m/%Y')
	
	powerConsumptionDT$DATETIME <- strptime(paste(powerConsumptionDT$DATE,powerConsumptionDT$TIME), format='%Y-%m-%d %H:%M:%S')
	powerConsumptionDT$DATE <- NULL
	powerConsumptionDT$TIME <- NULL
	
	powerConsumptionDT <- powerConsumptionDT[, c(ncol(powerConsumptionDT), 1:(ncol(powerConsumptionDT)-1))]
	
	
	png(filename="plot1.png", width=480, height = 480, units = 'px')
	histplot <- hist(powerConsumtionDT$GLOBAL_ACTIVE_POWER, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="orangered3")
	dev.off()
}