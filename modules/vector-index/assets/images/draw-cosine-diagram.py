import matplotlib.pyplot as plt
import numpy as np


def calculate_midpoint(origin, vector):
    """
    Calculate the midpoint of a vector given an origin.
    
    Parameters:
    origin (array-like): The coordinates of the origin (x, y, z).
    vector (array-like): The components of the vector (vx, vy, vz).
    
    Returns:
    numpy array: The coordinates of the midpoint.
    """
    origin = np.array(origin)
    vector = np.array(vector)
    endpoint = origin + vector
    midpoint = (origin + endpoint) / 2
    return midpoint


def calculate_endpoint(origin, vector):
    """
    Calculate the midpoint of a vector given an origin.
    
    Parameters:
    origin (array-like): The coordinates of the origin (x, y, z).
    vector (array-like): The components of the vector (vx, vy, vz).
    
    Returns:
    numpy array: The coordinates of the midpoint.
    """
    origin = np.array(origin)
    vector = np.array(vector)
    endpoint = origin + vector
    return endpoint

def vector_magnitude(origin, vector):
    # Convert origin and vector to numpy arrays
    origin = np.array(origin)
    vector = np.array(vector)
    
    # Calculate the difference between the origin and vector
    diff = vector - origin
    
    # Calculate the magnitude (Euclidean distance)
    magnitude = np.linalg.norm(diff)
    
    return magnitude

def normalize(vector, origin=None):
    if origin is not None:
        # Subtract origin from the vector
        vector = np.array(vector) - np.array(origin)
    # Calculate the magnitude of the vector
    magnitude = np.linalg.norm(vector)
    # Normalize the vector
    return vector / magnitude

# Define two vectors in 3D space
v1 = np.array([2, 3, 5])
v2 = np.array([6, 4, 6])

v1_origin = np.array([0, 0, 0])
v2_origin = np.array([1, 0, 0])

v1_norm = normalize(v1, v1_origin)
v2_norm = normalize(v2, v2_origin)

# Define two points in 3D space
#point1 = np.array([2, 3, 5])
#point2 = np.array([6, 7, 2])
point1 = calculate_endpoint(v1_origin, v1_norm)
point2 = calculate_endpoint(v2_origin, v2_norm)


# Compute a vector from point1 to point2
vector = point2 - point1
midpoint = (point1 + point2) / 2

# Find a perpendicular vector (normal to the line connecting the two points)
arbitrary_vector = np.array([1, 0, 0]) if vector[0] == 0 else np.array([0, 1, 0])
normal_vector = np.cross(vector, arbitrary_vector).astype(float)  # Convert to float
normal_vector /= np.linalg.norm(normal_vector)  # Normalize the normal vector

# Control the "height" of the arc (smaller values for a shallower arc)
arc_height = 0.5

# Generate points on the arc
t = np.linspace(0, 1, 100)
arc_points = (1 - t)[:, None] * point1 + t[:, None] * point2 + arc_height * np.sin(np.pi * t)[:, None] * normal_vector

# Set up the plot
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Plot the vectors
ax.quiver(0, 0, 0, v1_norm[0], v1_norm[1], v1_norm[2], color='b',  linewidth=2)
ax.quiver(1, 0, 0, v2_norm[0], v2_norm[1], v2_norm[2], color='r',  linewidth=2)

# Plot the original points
ax.scatter(*point1, color='b', s=100)
ax.scatter(*point2, color='r', s=100)

# Plot the arc
ax.plot3D(arc_points[:, 0], arc_points[:, 1], arc_points[:, 2], 'g', linestyle='dotted', linewidth=2)

# Label the arc
ax.text(*midpoint, r'$\theta$', color='k', fontsize=14)

# Move the lables showing the vector magnitude a bit.
# text_offset = np.array([-1.3, 0, 2])

# Add vector magnitudes
#ax.text(*(point1 + text_offset), r'$\left| \mathbf{v_1} \right| = $' + "{:.2f}".format(vector_magnitude(v1_origin, v1)), color='b', fontsize=14)


#ax.text(*(point2 + text_offset), r'$\left| \mathbf{v_2} \right| = $' + "{:.2f}".format(vector_magnitude(v2_origin, v2)), color='r', fontsize=14)




# Set axis limits and labels
ax.set_xlim(0, 2)
ax.set_ylim(0, 2)
ax.set_zlim(0, 2)

# The values on the axes were too close together, so this will filter out
# half of them.

# Get the current ticks
x_ticks = ax.get_xticks()
y_ticks = ax.get_yticks()
z_ticks = ax.get_zticks()

# Filter the ticks to show every other tick
x_ticks_custom = x_ticks[::2]
y_ticks_custom = y_ticks[::2]
z_ticks_custom = z_ticks[::2]

# Set the custom ticks
ax.set_xticks(x_ticks_custom)
ax.set_yticks(y_ticks_custom)
ax.set_zticks(z_ticks_custom)


ax.set_xlabel('X-axis')
ax.set_ylabel('Y-axis')
ax.set_zlabel('Z-axis')
ax.set_title('Cosine Similarity')

# Show plot
#plt.show()
plt.savefig('cosine-similarity-example.svg')  # Save as an image
