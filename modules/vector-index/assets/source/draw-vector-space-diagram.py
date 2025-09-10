# Script to generate the 3D vector diagram in 
# This mainly came about because ChatGPT lied to me about Kroki supporting
# Matplotlib. It does not. Instead of throwing away the work to generate this
# diagram, I'll just check in the source code and include the SVG file in the document.
#
# If You need to update this diagram, you will need to install Python 3, numpy and
# matplotlib. On MacOS, this can be done via the brew command.

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Define the AI embedded vectors for feral cats, domestic cats, and Linux command line cat tool
feral_cats_vector = np.array([0.13, 0.21, 0.34])
domestic_cats_vector = np.array([0.1, 0.27, 0.30])
linux_cat_vector = np.array([0.4, 0.4, 0.3])

# Create a figure and a 3D axis
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Plot the vectors
ax.quiver(0, 0, 0.1, feral_cats_vector[0], feral_cats_vector[1], feral_cats_vector[2], color='indianred', label='Feral Cats')
ax.quiver(0, 0.1, 0, domestic_cats_vector[0], domestic_cats_vector[1], domestic_cats_vector[2], color='darkred', label='Domestic Cats')
ax.quiver(0.4, 0.3, 0.1, linux_cat_vector[0], linux_cat_vector[1], linux_cat_vector[2], color='green', label='Linux Cat Command')

# Set the plot labels
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

# Set the plot limits
ax.set_xlim([0.0, 0.8])
ax.set_ylim([0.0, 0.8])
ax.set_zlim([0.0, 0.8])

# Add a legend
ax.legend()

plt.savefig('vector-space-example.svg')  # Save as an image
plt.close()
