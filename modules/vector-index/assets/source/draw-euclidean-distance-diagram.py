# Illustrates how euclidean distance works
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# Define two vectors in 3D space
v1 = np.array([2, 3, 5])
v2 = np.array([6, 4, 6])

v1_one_third = (1/3) * v1
v2_one_third = (1/3) * v2

v1_two_third = (2/3) * v1
v2_two_third = (2/3) * v2



# Set up the 3D plot
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')

# Plot the vectors
ax.quiver(0, 0, 0, v1[0], v1[1], v1[2], color='b',  linewidth=2)
ax.quiver(1, 1, 1, v2[0], v2[1], v2[2], color='r',  linewidth=2)

# Plot points
ax.scatter(0,0,0, color='r', s=100)
ax.scatter(1,1,1, color='r', s=100)

ax.scatter(v1_one_third[0],v1_one_third[1],v1_one_third[2], color='r', s=100)
ax.scatter(v2_one_third[0]+1,v2_one_third[1]+1,v2_one_third[2]+1, color='r', s=100)

ax.scatter(v1_two_third[0],v1_two_third[1],v1_two_third[2], color='r', s=100)
ax.scatter(v2_two_third[0]+1,v2_two_third[1]+1,v2_two_third[2]+1, color='r', s=100)

# Draw dotted lines connecting corresponding points on the two vectors

ax.plot([0,1], [0,1], [0,1], linestyle='dotted', color='k')

ax.plot([v1_one_third[0], v2_one_third[0]+1], [v1_one_third[1], v2_one_third[1]+1], [v1_one_third[2], v2_one_third[2]+1], linestyle='dotted', color='k')

ax.plot([v1_two_third[0], v2_two_third[0]+1], [v1_two_third[1], v2_two_third[1]+1], [v1_two_third[2], v2_two_third[2]+1], linestyle='dotted', color='k')



#ax.plot([v1[0], v2[0]], [v1[1], v1[1]], [v1[2], v1[2]], linestyle='dotted', color='k')  # X-axis difference
#ax.plot([v2[0], v2[0]], [v1[1], v2[1]], [v1[2], v1[2]], linestyle='dotted', color='k')  # Y-axis difference
#ax.plot([v2[0], v2[0]], [v2[1], v2[1]], [v1[2], v2[2]], linestyle='dotted', color='k')  # Z-axis difference

# Highlight the Euclidean distance with a line between the vector endpoints
ax.plot([v1[0], v2[0]+1], [v1[1], v2[1]+1], [v1[2], v2[2]+1], color='k', linestyle='dotted')

# Set axis limits for better visibility
ax.set_xlim(0, 7)
ax.set_ylim(0, 7)
ax.set_zlim(0, 7)

# Labels and title
ax.set_xlabel('X-axis')
ax.set_ylabel('Y-axis')
ax.set_zlabel('Z-axis')
ax.set_title('Euclidean Distance')
ax.legend()

# Show plot
#plt.show()
plt.savefig('euclidean-distance-example.svg')  # Save as an image