
y'/z' = y/z => y' = yz'/z

where y' is projection of actual y on the screen and z' is the distance of viewer from the screen.
So, assuming z' is constant

(x', y') = (kx/z, ky/z)   # changing k will change the field of view of the 3d object on the screen

How to draw a torus?
Draw a circle in 3D space and then rotate it around the axis of the torus
A circle of radius R1 centered at point (R2, 0, 0) drawn in the xy plane, when rotated around y axis (i.e. in xz plane) at an angle phi.
circle in 2D plane - (x,y,z) = (R2,0,0) + (R1sin(theta), R1cos(theta), 0)
circle in 3D plane - (R2+R1*sin(theta), R1cos(theta), 0).[cos(phi)  0  sin(phi)
                                                             0      1     0   
                                                          -sin(phi) 0 cos(phi)]
                   = ((R2+R1cos(theta))cos(phi), R1sin(theta), -(R2 + R1cos(theta))sin(phi))
                   
To animate the donut by spinning it across x axis and z axis we'll need to multiply the above result with 2 more rotation matrices

These x,y,z refer to points on the torus. To actually render the torus
- we need to move the torus by z distance to make it visible to the viewer (viewer is at origin)
- Project from 3d onto our 2d screen

so now, (x', y') = (k1x/k2 + z, k1y/k2+z) where k1 = distance of viewer from screen and k2 is traversal of torus from origin . They define the field of view and flatter or exaggerate the depth of the object


Final result after multiplication with rotation matrices across 3 axes.
x   = (R2+R1cosθ)(cosBcosϕ+sinAsinBsinϕ)−R1cosAsinBsinθ
y   = (R2+R1cosθ)(cosϕsinB−cosBsinAsinϕ)+R1cosAcosBsinθ
z   = cosA(R2+R1cosθ)sinϕ+R1sinAsinθ

To calculate illumination, we use the surface normal, the direction perpendicular to the surface at each point.
The we can use the dot product of surface normal with the direction of light to gain illumination. 

Luminance = cosϕcosθsinB−cosAcosθsinϕ−sinAsinθ+cosB(cosAsinθ−cosθsinAsinϕ)
    


























Reference: https://www.a1k0n.net/2011/07/20/donut-math.html
