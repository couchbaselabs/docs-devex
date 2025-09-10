# Illustrates how euclidean distance works
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d.proj3d import proj_transform
import numpy as np
import random


# Draws a cluster of random points around a point in space, labels the center with a star, and draws a 
# sphere around the area.
def draw_cluster(x, y, z, color, dist=0.4, numpoints=10):
    point_list = ''
    # Draw some random points around the area 
    my_xs = []
    my_ys = []
    my_zs = []
    for point in range(numpoints):
        my_x = random.uniform(x-dist, x+dist)
        my_y = random.uniform(y-dist, y+dist)
        my_z = random.uniform(z-dist, z+dist)                  
        ax.scatter(my_x, my_y, my_z, color=color, s=40, alpha=0.8)
        point_list += f'     {point}: [{my_x:.4f}, {my_y:.4f}, {my_z:.4f}]\n'
        my_xs.append(my_x)
        my_ys.append(my_y)
        my_zs.append(my_z)

    # Find center of all random points getting average of points
    cx = np.mean(my_xs)
    cy = np.mean(my_ys)
    cz = np.mean(my_zs)

    # Plot centroid as a star
    ax.scatter(cx, cy, cz, color=color, marker='*', s=100, edgecolors='black')

    # Draw a sphere to highlight the area
    radius = dist + 0.1
    u = np.linspace(0, 2 * np.pi, 100)
    v = np.linspace(0, np.pi, 100)
    sx = radius * np.outer(np.cos(u), np.sin(v)) + cx
    sy = radius * np.outer(np.sin(u), np.sin(v)) + cy
    sz = radius * np.outer(np.ones(np.size(u)), np.cos(v)) + cz
    # Add the sphere as a transparent surface
    ax.plot_surface(sx, sy, sz, color=color, alpha=0.2)
    point_list = f'centroid [{cx:.4f}, {cy:.4f}, {cz:.4f}] ({color})\n' + point_list
    return point_list

# Set up the 3D plot
fig = plt.figure(figsize=(12, 6))
ax = fig.add_subplot(111, projection='3d')

# Move the 3D plot to the left
ax.set_position([0.05, 0.1, 0.5, 0.8])  # [left, bottom, width, height]

# Adjust size of 3d plot
fig.subplots_adjust(left=0.0, right=0.5, top=0.9, bottom=0.1)

point_list = 'All points:\n'

# Call to create a bunch of regions
point_list += draw_cluster(0.8, 0.5, 0.7, 'red', 0.15, 10)
point_list += draw_cluster(0.1, 0.1, 0.5, 'blue', 0.1, 10)
point_list += draw_cluster(0.75, 0.2, 0.3, 'green', 0.2, 15)
point_list += draw_cluster(0.2, 0.8, 0.6, 'orange', 0.15, 10)
point_list += draw_cluster(0.1, 0.7, 0.15, 'purple', 0.1, 5)
point_list += draw_cluster(0.25, 0.3, 0.1, 'maroon', 0.1, 5)
point_list += draw_cluster(0.6, 0.9, 0.85, 'cyan', 0.1, 5)

print(point_list)

# Set axis limits for better visibility
ax.set_xlim(0, 1)
ax.set_ylim(0, 1)
ax.set_zlim(0, 1)

# Suppress numeric labels
ax.set_xticklabels([])
ax.set_yticklabels([])
ax.set_zticklabels([])


# Show plot

plt.savefig('pq-centroid-diagram.svg')  # Save as an image
plt.savefig('pq-centroid-diagram.png')  # Save as an image
plt.show()