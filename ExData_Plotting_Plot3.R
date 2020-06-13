##Creating a Directory
if (!file.exists("data")) {
  dir.create("./data")
}

##Downloading and Unzipping the file
fileURL <-
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./data/household_power_consumption.zip")

unzip("./data/household_power_consumption.zip", exdir = "./data")

##Load the file in a Data Frame
powerFull <-
  read.csv("./data/household_power_consumption.txt", sep = ";")

#Create a new column called UpdatedDate in the dataframe (Date column converted to the Date datatype)
powerFull$Date <- as.Date(as.character(powerFull$Date), "%d/%m/%Y")

#Subset based on the 2 dates we are interested in
power <-
  subset(powerFull, (Date >= as.Date("2007-02-01")) &
           (Date <= as.Date("2007-02-02")))

#Convert to appropriate datatypes
power$Global_active_power <-
  as.numeric(as.character(power$Global_active_power))
power$Global_reactive_power <-
  as.numeric(as.character(power$Global_reactive_power))
power$Voltage <- as.numeric(as.character(power$Voltage))
power$Global_intensity <-
  as.numeric(as.character(power$Global_intensity))
power$Sub_metering_1 <-
  as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <-
  as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <-
  as.numeric(as.character(power$Sub_metering_3))
power$Time <-
  strptime(paste(as.character(power$Date), power$Time), "%Y-%m-%d  %H:%M:%S")


#Plot 3 - All 3 Sub_Metering on 1 Graph with Legends
plot(
  power$Time,
  power$Sub_metering_1,
  type = "l",
  col = "black",
  main = "Energy Sub Metering by Day",
  xlab = "Date-Time",
  ylab = "Energy Sub Metering"
)
points(power$Time,
       power$Sub_metering_2,
       type = "l",
       col = "red")
points(power$Time,
       power$Sub_metering_3,
       type = "l",
       col = "blue")
legend(
  "topright",
  legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"),
  col = c("black", "red", "blue"),
  lty = c(1, 1, 1)
)
dev.copy(png, "Plot3-Energy_Sub_Metering_By_Time.png")
dev.off()

