# install.packages("DeliveryMan_1.1.0.zip",repos=NULL)
library(DeliveryMan)

main <- function(traffic, car, packets) {
  if (counter == 0) {
    print(traffic)
    target = getNextPacketPosition(packets)
    print(sprintf("Target: %d", target))
    print(sprintf("Car x: %s", car$x))
    print(sprintf("Car y: %s", car$y))
    heuristic = getHeuristic(car$x, target[1], car$y, target[2])
    print(sprintf("Car h=(%d)",heuristic))
    list = c(node_x=car$x, node_y=car$y, dist=0, heuristic=heuristic)
    
    record <<- data.frame( 
                            node_x=car$x,
                            node_y=car$y,
                            dist=0,
                            heuristic=heuristic,
                            stringsAsFactors=F
                            )
    
    addFrontier(record)
    expandNeighbours(car$x, car$y, record)
  }
  
  #addFrontier(list)
  #print(frontier)
  #expandNeighbours(car$x, car$y)
  counter <<- counter + 1
}

testDM(main, verbose = 0, returnVec = FALSE, n = 500, seed = 21, timeLimit = 250)

frontier <<- NULL
row <- 0
col <- 4
counter <- 0

expandNeighbours <- function(x, y, record) {
  
}

deleteFrontier <- function() {
  # https://stackoverflow.com/questions/6650510/remove-rows-from-data-frame-where-a-row-match-a-string
}

addFrontier <- function(record) {
  frontier <<- rbind(frontier, record)
}

getNextPacketPosition <- function(packets) {
  if (packets[1,5] == 0) { return (c(packets[1,1], packets[1,2])) }
  if (packets[2,5] == 0) { return (c(packets[2,1], packets[2,2])) }
  if (packets[3,5] == 0) { return (c(packets[3,1], packets[3,2])) }
  if (packets[4,5] == 0) { return (c(packets[4,1], packets[4,2])) }
  if (packets[5,5] == 0) { return (c(packets[5,1], packets[5,2])) }
  return (NULL)
}

getHeuristic <- function(x_from, x_to, y_from, y_to, ManhattanDistance=T){
  # ManhattanDistance
  if (ManhattanDistance) { return (abs(x_to - x_from) + abs(y_to - y_from)) }
}


