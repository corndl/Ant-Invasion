/*
  In this project, the screen is made into a grid : each tile
  of that grid can contain informations : 
    - Ants
    - The Colony
    - A Food Spot
    - Pheromones
    
  Ants spawn from the Colony and try to find food and gather it at the
  Colony. For that purpose, they leave pheromones behind them to share
  the whereabouts of the food spots with the other ants.

  The Colony, Food Spot and Pheromones are drawn wider than they are : 
  all objects are really just dots, so it may often look like an ant 
  has found a food spot while it only merely got close to it.
*/

Grid g;
Generator gen;
int _width, _height, nbAnts, nbFoodSpots, pheromoneCooldown;

void setup() {
  _width = (int) displayWidth / 3;
  _height = (int) displayHeight / 3;
  size(_width, _height);
  
  // PARAMETERS
  nbAnts = 1000;
  nbFoodSpots = 100;
  pheromoneCooldown = 5;
  
  g = new Grid(_width, _height);
  gen = new Generator(_width, _height, g);
  gen.Generate(nbAnts, nbFoodSpots);
}

void draw() {
  background(255);
  for (int i = 0; i < _width; i++) {
    for (int j = 0; j < _height; j++) {
      // Draw the colony
      if (g.tiles[i][j].IsColony)
        ellipse(i, j, 5, 5);
      
      // Draw the food
      else if (g.tiles[i][j].HasFood) {
        stroke(0);
        fill(150);
        rect(i, j, 5, 5);
      }
      
      // Draw the ants
      else if (g.tiles[i][j].HasAnt)
        ellipse(i, j, 1, 1);
      
      // Draw the Pheromones (1 in 5)
      if (g.tiles[i][j].HasPheromone && ( (i % 5 == 0 || j % 5 == 0) && !(i % 5 == 0 && j % 5 == 0) ) ) {
        int s = second();
        int m = minute();
        // Kill the pheromones after a certain time
        if (m * 60 + s > g.tiles[i][j].GetPheromone().instantiationTime + pheromoneCooldown)
          g.tiles[i][j].DestroyPheromone();
          
        stroke(255,0,0);      
        noFill();
        ellipse(i, j, 5, 5);
        stroke(0);
      }
    }
  }
  
  for (int i = 0; i < nbAnts; i++) {
    gen.ants[i].Run(); 
  }
  fill(0);
}
