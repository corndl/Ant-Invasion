class Grid {
  /*
    The screen is divided into a grid : each tile of that grid can contain 
    informations : 
      - Ants
      - The Colony
      - A Food Spot
      - Pheromones
      
    The grid really just is a collection of tiles.
  */
  
  private int _width;
  private int _height;
  
  public Tile[][] tiles;
  
  Grid(int w, int h) {
    _width = w;
    _height = h;
    
    tiles = new Tile[_width][_height];
    
    InstantiateTiles();    
  }
  
  private void InstantiateTiles() {
    Tile t;
    for (int i = 0; i < _width; i++) {
      for (int j = 0; j < _height; j++) {
        t = new Tile(i, j);
        tiles[i][j] = t;
      }
    }  
  }
  
}
