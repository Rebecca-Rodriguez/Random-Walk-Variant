import controlP5.*;

ControlP5 cp5;

// UI objects
Button startButton;
DropdownList dropDown;
Textlabel stepsLabel, rateLabel, sizeLabel, scaleLabel;
Slider stepsSlider, rateSlider, sizeSlider, scaleSlider;
Toggle constrainToggle, simulateToggle, strokeToggle, seedToggle;
Textfield seedText;

// Variables
RandomWalkBaseClass object = null;
boolean gameOn = false;
boolean needReset = true;

int backgroundValue = color(201, 200, 201);
int backgroundUI = color(100, 100, 100);
int backgroundSQ = color(201, 200, 201);
int backgroundHX = color(71, 144, 208);

int maxSteps = 50000;
int takenSteps = 0;
int stepRate = 1;
int sizeStep = 10;
float scaleStep = 1.0f;
String seedValue = "0";

void setup()
{
  size(1200, 800);
  reset(backgroundValue);
  cp5 = new ControlP5(this);

  // Buttons
  startButton = cp5.addButton("gameOn")
    .setPosition(10, 10)
    .setSize(100, 40);
  startButton.getCaptionLabel().setText("START");
  startButton.setColorBackground(color(0, 150, 0));

  // DropdownList
  dropDown = cp5.addDropdownList("SQUARES")
    .setPosition(10, 60)
    .setSize(140, 120)
    .setItemHeight(40)
    .setBarHeight(40)
    .addItem("SQUARES", 0)
    .addItem("HEXAGONS", 1);

  // Slider - steps
  stepsLabel = cp5.addTextlabel("stepsLabel")
    .setText("Maximum Steps")
    .setPosition(10, 218);
  stepsSlider = cp5.addSlider("maxSteps", 100, 50000)
    .setDecimalPrecision(0)
    .setPosition(10, 230)
    .setSize(180, 25);
  stepsSlider
    .getCaptionLabel()
    .setVisible(false);

  // Slider - rate
  rateLabel = cp5.addTextlabel("rateLabel")
    .setText("Step Rate")
    .setPosition(10, 278);
  rateSlider = cp5.addSlider("stepRate", 1, 1000)
    .setPosition(10, 290)
    .setSize(180, 25);
  rateSlider
    .getCaptionLabel()
    .setVisible(false);

  // Slider - size
  sizeLabel = cp5.addTextlabel("sizeLabel")
    .setText("Step Size")
    .setPosition(10, 338);
  sizeSlider = cp5.addSlider("sizeStep", 10, 30)
    //    .setDecimalPrecision(0)
    .setPosition(10, 350)
    .setSize(80, 25);
  sizeSlider
    .getCaptionLabel()
    .setVisible(false);

  // Slider - scale
  scaleLabel = cp5.addTextlabel("scaleLabel")
    .setText("Step Scale")
    .setPosition(10, 388);
  scaleSlider = cp5.addSlider("scaleStep", 1.0, 1.5)
    .setPosition(10, 400)
    .setSize(80, 25);
  scaleSlider
    .getCaptionLabel()
    .setVisible(false);

  // Toggle - constrain
  constrainToggle = cp5.addToggle("constrain")
    .setPosition(10, 450)
    .setSize(25, 25);
  constrainToggle.getCaptionLabel().setText("CONSTRAIN STEPS");

  // Toggle - simulate
  simulateToggle = cp5.addToggle("simulate")
    .setPosition(10, 500)
    .setSize(25, 25);
  simulateToggle.getCaptionLabel().setText("SIMULATE TERRAIN");

  // Toggle - stroke
  strokeToggle = cp5.addToggle("useStroke")
    .setPosition(10, 550)
    .setSize(25, 25);
  strokeToggle.getCaptionLabel().setText("USE STROKE");

  // Toggle - seed
  seedToggle = cp5.addToggle("seed")
    .setPosition(10, 600)
    .setSize(25, 25);
  seedToggle.getCaptionLabel().setText("USE RANDOM SEED");

  // Textfield
  seedText = cp5.addTextfield("seedValue")
    .setPosition(100, 600)
    .setSize(60, 25)
    .setInputFilter(ControlP5.INTEGER)
    .setText("0");
  seedText.getCaptionLabel().setText("SEED VALUE");
}

void reset(int backgroundValue)
{
  background(backgroundValue);
  rectMode(LEFT);
  strokeWeight(0);
  fill(backgroundUI);
  rect(0, 0, 200, height);
}

void gameOn()
{
  gameOn = true;
  if (needReset)
  {
    backgroundValue = setBackground();
    reset(backgroundValue);

    boolean constrain = constrainToggle.getState();
    boolean useStroke = strokeToggle.getState();
    boolean simulate = simulateToggle.getState();
    boolean seed = seedToggle.getState();
    int seedValue = Integer.parseInt(seedText.getText());

    // Check for type selected
    if (dropDown.getValue() == 0) {
      object = new SquareClass(sizeStep, scaleStep, constrain, useStroke, simulate, seed, seedValue);
    } else if (dropDown.getValue() == 1) {
      object = new HexagonClass(sizeStep, scaleStep, constrain, useStroke, simulate, seed, seedValue);
    }

    object.reset();
    takenSteps = 0;
    needReset = false;
  }
}

void draw()
{
  if (gameOn)
  {
    gameOn();
    object.useSeed();
    for (int i = 0; i < stepRate; i++)
    {
      if (stepRate > maxSteps)
      {
        stepRate = maxSteps;
      }
      object.Update();
      object.Draw();
      takenSteps++;
      if (takenSteps >= maxSteps)
      {
        gameOn = false;
        needReset = true;
      }
    }
  }
}

int setBackground()
{
  // Check for type selected
  if (dropDown.getValue() == 1) {
    return backgroundHX;
  } else {
    return backgroundSQ;
  }
}
