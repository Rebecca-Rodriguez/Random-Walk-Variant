class SquareClass extends RandomWalkBaseClass
{
  SquareClass(int sizeStep, float scaleStep, boolean constrain, boolean useStroke, boolean simulate, boolean seed, int seedValue)
  {
    this.sizeStep = sizeStep;
    this.scaleStep = scaleStep;
    this.constrain = constrain;
    this.useStroke = useStroke;
    this.simulate = simulate;
    this.newSize = sizeStep * scaleStep;
    this.seed = seed;
    this.seedValue = seedValue;
  }

  void Update()
  {
    int rand = (int)random(0, 4);

    if (rand == 0)
    {
      currentPos.y += newSize;
    } else if (rand == 1)
    {
      currentPos.y -= newSize;
    } else if (rand == 2)
    {
      currentPos.x += newSize;
    } else if (rand == 3)
    {
      currentPos.x -= newSize;
    }

    updateMap();
  }
  void Draw()
  {
    constrainSteps();
    simulateTerrain();
    useStroke();

    rectMode(CENTER);
    rect(currentPos.x, currentPos.y, sizeStep, sizeStep);
  }

  void updateMap()
  {
    if (map.containsKey(currentPos))
    {
      map.put(currentPos, map.get(currentPos) + 1);
    } else {
      map.put(currentPos, 1);
    }
  }

  void constrainSteps()
  {
    float halfStep = newSize/2;

    if (currentPos.x < 200 + halfStep)
      currentPos.x += newSize;

    if (!constrain)
      return;

    if (currentPos.x > width - halfStep)
      currentPos.x -= newSize;

    if (currentPos.y < halfStep)
      currentPos.y += newSize;

    if (currentPos.y > height - halfStep)
      currentPos.y -= newSize;
  }
  void simulateTerrain()
  {
    int currColor = 0;
    if (!simulate)
    {
      currColor = purple;
    }

    if (simulate)
    {
      if (map.get(currentPos) < 4)
        currColor = dirt;
      else if (map.get(currentPos) < 7)
        currColor = grass;
      else if (map.get(currentPos) < 10)
        currColor = rock;
      else
      {
        currColor = map.get(currentPos) * 20;
        if (currColor > 255)
          currColor = 255;
      }
    }

    stroke(currColor);
    fill(currColor);
  }
}
