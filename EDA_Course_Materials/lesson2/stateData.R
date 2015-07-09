statesInfo <- read.csv('stateData.csv')
View(statesInfo)

subset(statesInfo, state.region == 1)
statesInfo[statesInfo$state.region == 1, ]
