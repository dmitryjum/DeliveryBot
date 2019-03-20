## Deliverybot class
Deliverybot class instantiates with a string argument that contains even number of arguments, first 2 of which define a grid (Cartesian plane) with X and Y axes and
the rest are delivery coordinates. Expected string example: "5x5 (1, 3) (4, 4)". But " 5 5 1 3 4 4" should work as well. Instance method #generate_directions return a string with first letter of cardinal directions per each step and letter D if current step and expected coordinates match and bot has to exercise a package drop.

### Local software prerequisites
- Ruby 2.6.0 (but erlier versions will most likely work)
- Rspec 3.8.0

### Run tests
```
rspec
```

### Run the application
```
ruby deliverybot.rb
```

### Helpful information

While public method #generation_directions is relatively clear, it calls private method #next_stop with destination coordinates. The logic of #next_stop
compares current pointer position on X and Y axes to next step coordinates, calculate the step distance and pushes directional letters to the result array per each step. It reduces or increases current position X and Y axes numbers per iteration to maintain information about the pointer at each given step.