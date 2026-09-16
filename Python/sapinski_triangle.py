from matplotlib import pyplot as plt
import random

# Select three random triangle points
tri = [[0.0, 0.0], [259.807, 150], [0.0, 300]]
xmax = 300
ymax = 259.807
co_ord_list = [[tri[0][0], tri[1][0], tri[2][0]], [tri[0][1], tri[1][1], tri[2][1]]]
yp = random.uniform(0, ymax)
xp = random.uniform(0, xmax)

c1 = (tri[1][1]-tri[0][1])*(yp-tri[0][0])-(tri[1][0]-tri[0][0])*(xp-tri[0][1])
c2 = (tri[2][1]-tri[1][1])*(yp-tri[1][0])-(tri[2][0]-tri[1][0])*(xp-tri[1][1])
c3 = (tri[0][1]-tri[2][1])*(yp-tri[2][0])-(tri[0][0]-tri[2][0])*(xp-tri[2][1])

while not ( (c1<0 and c2<0 and c3<0) or (c1>0 and c2>0 and c3>0) ):
    yp = random.uniform(0, ymax)
    xp = random.uniform(0, xmax)
    c1 = (tri[1][1]-tri[0][1])*(yp-tri[0][0])-(tri[1][0]-tri[0][0])*(xp-tri[0][1])
    c2 = (tri[2][1]-tri[1][1])*(yp-tri[1][0])-(tri[2][0]-tri[1][0])*(xp-tri[1][1])
    c3 = (tri[0][1]-tri[2][1])*(yp-tri[2][0])-(tri[0][0]-tri[2][0])*(xp-tri[2][1])

choices = []

for loop_var in range(200000):
    co_ord_list[0].append(yp)
    co_ord_list[1].append(xp)
    point_index = random.choice([0,1,2])
    choices.append(point_index)
    yp = abs(((yp + tri[point_index][0])/2))
    xp = abs(((xp + tri[point_index][1])/2))

co_ord_list[0].append(yp)
co_ord_list[1].append(xp)
random_choice = [choices.count(0), choices.count(1), choices.count(2)]
print(random_choice)

plt.figure()
plt.scatter(co_ord_list[1],co_ord_list[0],s=0.05)

plt.show()