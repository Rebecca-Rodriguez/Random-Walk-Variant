class RandomWalkBaseClass
{
  PVector currentPos = new PVector();
  HashMap<PVector, Integer> map = new HashMap<PVector, Integer>();

  int purple = color(167, 100, 200);
  int dirt = color(160, 126, 84);
  int grass = color(143, 170, 64);
  int rock = color(135, 135, 135);

  int sizeStep;
  float scaleStep;
  float newSize;
  boolean constrain;
  boolean useStroke;
  boolean simulate;
  boolean seed;
  int seedValue;

  RandomWalkBaseClass()
  {
    reset();
  }

  void reset()
  {
    // Starting point in the middle of the screen
    currentPos.x = width/2 + 100;
    currentPos.y = height/2;
  }
  void Update()
  {
  }

  void Draw()
  {
  }

  void useStroke()
  {
    if (useStroke)
    {
      stroke(0);
      strokeWeight(1);
    } else
    {
      strokeWeight(0);
    }
  }

  void useSeed()
  {
    if (seed)
    {
      randomSeed(seedValue);
    }
  }
}
