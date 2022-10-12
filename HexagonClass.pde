class HexagonClass extends RandomWalkBaseClass
{
  PVector hexCoordinate;

  HexagonClass(int sizeStep, float scaleStep, boolean constrain, boolean useStroke, boolean simulate, boolean seed, int seedValue)
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
    int rand = (int)random(1, 7);
    if (rand == 1)
    {
      currentPos.x += cos(radians(30)) * sqrt(3) * (newSize);
      currentPos.y += sin(radians(30)) * sqrt(3) * (newSize);
    } else if (rand == 2)
    {
      currentPos.x += cos(radians(90)) * sqrt(3) * (newSize);
      currentPos.y += sin(radians(90)) * sqrt(3) * (newSize);
    } else if (rand == 3)
    {
      currentPos.x += cos(radians(150)) * sqrt(3) * (newSize);
      currentPos.y += sin(radians(150)) * sqrt(3) * (newSize);
    } else if (rand == 4)
    {
      currentPos.x += cos(radians(210)) * sqrt(3) * (newSize);
      currentPos.y += sin(radians(210)) * sqrt(3) * (newSize);
    } else if (rand == 5)
    {
      currentPos.x += cos(radians(270)) * sqrt(3) * (newSize);
      currentPos.y += sin(radians(270)) * sqrt(3) * (newSize);
    } else if (rand == 6)
    {
      currentPos.x += cos(radians(330)) * sqrt(3) * (newSize);
      currentPos.y += sin(radians(330)) * sqrt(3) * (newSize);
    }

    hexCoordinate = CartesianToHex(currentPos.x, currentPos.y, sizeStep, scaleStep, width/2 + 100, height/2);

    updateMap(hexCoordinate);
  }
  void Draw()
  {
    constrainSteps();
    simulateTerrain();
    useStroke();

    beginShape();
    for (int i = 0; i <= 360; i+= 60)
    {
      float xPos = currentPos.x + cos(radians(i)) * sizeStep;
      float yPos = currentPos.y + sin(radians(i)) * sizeStep;

      vertex(xPos, yPos);
    }
    endShape();
  }

  PVector CartesianToHex(float xPos, float yPos, float hexRadius, float stepScale, float xOrigin, float yOrigin)
  {
    float startX = xPos - xOrigin;
    float startY = yPos - yOrigin;

    float col = (2.0/3.0f * startX) / (hexRadius * stepScale);
    float row = (-1.0f/3.0f * startX + 1/sqrt(3.0f) * startY) / (hexRadius * stepScale);

    /*===== Convert to Cube Coordinates =====*/
    float x = col;
    float z = row;
    float y = -x - z; // x + y + z = 0 in this system

    float roundX = round(x);
    float roundY = round(y);
    float roundZ = round(z);

    float xDiff = abs(roundX - x);
    float yDiff = abs(roundY - y);
    float zDiff = abs(roundZ - z);

    if (xDiff > yDiff && xDiff > zDiff)
      roundX = -roundY - roundZ;
    else if (yDiff > zDiff)
      roundY = -roundX - roundZ;
    else
      roundZ = -roundX - roundY;

    /*===== Convert Cube to Axial Coordinates =====*/
    PVector result = new PVector(roundX, roundZ);

    return result;
  }

  void updateMap(PVector hexCoordinate)
  {
    if (map.containsKey(hexCoordinate))
    {
      map.put(hexCoordinate, map.get(hexCoordinate) + 1);
    } else {
      map.put(hexCoordinate, 1);
    }
  }

  void constrainSteps()
  {

    if (currentPos.x < 200 + newSize)
    {
      if (currentPos.y < height/2)
      {
        currentPos.x += cos(radians(30)) * sqrt(3) * (newSize);
        currentPos.y += sin(radians(30)) * sqrt(3) * (newSize);
      } else
      {
        currentPos.x += cos(radians(330)) * sqrt(3) * (newSize);
        currentPos.y += sin(radians(330)) * sqrt(3) * (newSize);
      }
    }

    if (!constrain)
      return;

    if (currentPos.x > width - newSize)
    {
      if (currentPos.y < height/2)
      {
        currentPos.x += cos(radians(210)) * sqrt(3) * (newSize);
        currentPos.y += sin(radians(210)) * sqrt(3) * (newSize);
      } else
      {
        currentPos.x += cos(radians(150)) * sqrt(3) * (newSize);
        currentPos.y += sin(radians(150)) * sqrt(3) * (newSize);
      }
    }

    if (currentPos.y < newSize)
    {
      currentPos.x += cos(radians(90)) * sqrt(3) * (newSize);
      currentPos.y += sin(radians(90)) * sqrt(3) * (newSize);
    }

    if (currentPos.y > height - newSize)
    {
      currentPos.x += cos(radians(270)) * sqrt(3) * (newSize);
      currentPos.y += sin(radians(270)) * sqrt(3) * (newSize);
    }
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
      if (map.get(hexCoordinate) < 4)
        currColor = dirt;
      else if (map.get(hexCoordinate) < 7)
        currColor = grass;
      else if (map.get(hexCoordinate) < 10)
        currColor = rock;
      else
      {
        currColor = map.get(hexCoordinate) * 20;
        if (currColor > 255)
          currColor = 255;
      }
    }

    stroke(currColor);
    fill(currColor);
  }
}
