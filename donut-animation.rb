require 'gosu'

class Window < Gosu::Window

  PI = 3.14159

  def initialize
    super 640, 480
    self.caption = 'donut'

    @R1 = 1
    @R2 = 2
    @K1 = 150
    @K2 = 4

    @a = 1 # the angle of rotation of the donut across x axis
    @b = 1  # the angle of rotation of the donut across z axis
    @a_increment = 0.05
    @b_increment = 0.03

    @step_val = 0.1
    length = (0..2*PI).step(@step_val).size

    @point_grid = (0..2*PI).step(@step_val).map do |theta|
      (0..2*PI).step(@step_val).map do |phi|
        {x: 0,
         y: 0,
         luminance: 0,
         sin_theta: sin(theta),
         cos_theta: cos(theta),
         sin_phi: sin(phi),
         cos_phi: cos(phi),
        }
      end
    end

    @circle_image = Gosu::Image.new("./circle.png")
  end

  def update
    @a += @a_increment
    @b += @b_increment

    sin_a = sin(@a)
    sin_b = sin(@b)
    cos_a = cos(@a)
    cos_b = cos(@b)

    @point_grid.each do |row|
      row.each do |point|
        ox = @R2 + @R1 * point[:cos_theta]
        oy = @R1 * point[:sin_theta]

        x = ox * (cos_b * point[:cos_phi] + sin_a * sin_b * point[:sin_phi]) - oy * cos_a * sin_b
        y = ox * (sin_b * point[:cos_phi] - sin_a * cos_b * point[:sin_phi]) + oy * cos_a * cos_b

        z = @K2 + cos_a * ox * point[:sin_phi] + sin_a * oy
        z_inv = 1 / z

        point[:x] = (300 + @K1 * z_inv * x)
        point[:y] = (300 - @K1 * z_inv * y)

        point[:luminance] = 0.7 * (point[:cos_phi] * point[:cos_theta] * sin_b -
                                   cos_a * point[:cos_theta] * point[:sin_phi] -
                                   sin_a * point[:sin_theta] +
                                   cos_b * (cos_a * point[:sin_theta] - point[:cos_theta] * sin_a * point[:sin_phi]))

      end
    end

  end

  def draw
    @point_grid.each do |row|
      row.each do |point|
        @circle_image.draw(50 + point[:x], point[:y], point[:luminance], 0.01, 0.01, Gosu::Color.rgba(255, 255, 255, (128 * (point[:luminance] + 1))))
      end
    end
  end

  private

  def sin(angle)
    Math.sin(angle)
  end

  def cos(angle)
    Math.cos(angle)
  end
end

Window.new.show
