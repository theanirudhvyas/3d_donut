# frozen_string_literal: true

require 'ruby2d'

set title: 'donut'
set background: 'black'
set fps: 60

pi = 3.14
R1 = 1
R2 = 2
K1 = 150
K2 = 5

a = 1  # the angle of rotation of the donut across x axis
b = 1  # the angle of rotation of the donut across z axis

@@time = Time.now

def render_torus(a, b)
  clear

  current_time = Time.now
  puts current_time - @@time
  @@time = current_time

  cos_a = Math.cos(a)
  sin_a = Math.sin(a)
  cos_b = Math.cos(b)
  sin_b = Math.sin(b)

  for theta in (0..6.28).step(0.1)
    cos_theta = Math.cos(theta)
    sin_theta = Math.sin(theta)

    for phi in (0..6.28).step(0.1)
      sin_phi = Math.sin(phi)
      cos_phi = Math.cos(phi)

      ox = R2 + R1 * cos_theta # x position on 2D circle
      oy = R1 * sin_theta      # y position on 2D circle

      x = ox * (cos_b * cos_phi + sin_a * sin_b * sin_phi) - oy * cos_a * sin_b # final 3D x coordinate
      y = ox * (sin_b * cos_phi - sin_a * cos_b * sin_phi) + oy * cos_a * cos_b

      z = K2 + cos_a * ox * sin_phi + sin_a * oy
      z_inverse = 1 / z

      x_scaled = (300 + K1 * z_inverse * x)
      y_scaled = (300 - K1 * z_inverse * y)

      luminance = 0.7 * (cos_phi * cos_theta * sin_b - cos_a * cos_theta * sin_phi - sin_a * sin_theta + cos_b * (cos_a * sin_theta - cos_theta * sin_a * sin_phi))

      Circle.new(
        x: x_scaled,
        y: y_scaled,
        radius: luminance,
        sectors: 32,
        color: 'white'
      )
    end
  end

end

update do
  a += 0.07
  b += 0.03

  render_torus(a, b)
end

show
