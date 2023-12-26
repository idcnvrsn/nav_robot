import rospy

# from std_msgs.msg import Int32
from geometry_msgs.msg import PoseStamped
from actionlib_msgs.msg import GoalStatusArray
import random
import math

# goals=[[-1.0,1.6],[0.0,1.5],[-1.0,-0.5],[0.0,-0.5],[-1.0,-2.0],[0.0,-2.0],[2.0,-0.5],[-2.0,-0.5]]
# goals=[[2.0,1.0],[2.0,-1.0]]

goals=[]
for y in [-1.0, 0.0, 1.0, 2.0]:
    for x in [0.5, 1.5, 2.5]:
        goals.append([x,y])
goal_set=False

rospy.init_node('controller')
pub_goal = rospy.Publisher('move_base_simple/goal', PoseStamped, queue_size=1)

def get_goal(x, y, rad):
    goal = PoseStamped()
    goal.header.stamp=rospy.Time.now()
    goal.header.frame_id="map"
    goal.pose.position.x = x
    goal.pose.position.y = y
    goal.pose.orientation.w = math.cos(rad/2)
    goal.pose.orientation.x = 0
    goal.pose.orientation.y = 0
    goal.pose.orientation.z = math.sin(rad/2)
    return goal

goal=get_goal(0.0,0.0, 0)

def callback(msg):
    global goal_set
    global goal

    if len(msg.status_list) == 0:
        status = None
    else:
        status = msg.status_list[0].status
    if (status == 3) or (status == 4) or (status == None):
        if goal_set==False:
            idx=random.randint(0, len(goals))
            x=goals[idx][0]
            y=goals[idx][1]
            goal=get_goal(x, y, math.atan2(y-0.5,x-2.0))
            goal_set=True
        pub_goal.publish(goal)
    else:
        goal_set=False

    print(status, goal)#, goal_set)


sub = rospy.Subscriber('/move_base/status', GoalStatusArray, callback)
rospy.spin()



# goal = PoseStamped()
# goal.header.stamp=rospy.Time.now()
# goal.header.frame_id="map"
# goal.pose.position.x = -1.0
# goal.pose.position.y = -0.5
# goal.pose.orientation.w = 1.0

# rate = rospy.Rate(2)
# count = 0
# while not rospy.is_shutdown():
#     if count < 2:
#         pub_goal.publish(goal)
#         rate.sleep()
#     else:
#         break
#     count+=1




# while not rospy.is_shutdown():
# pub_goal.publish(goal)






# from std_msgs.msg import String
# pub = rospy.Publisher('chatter', String, queue_size=1)

# while not rospy.is_shutdown():
#     pub.publish('hello')


#  '{header: {frame_id: map}, pose: {pose: {position: {x: -2.0, y: -0.5}, orientation: {w: 1}}}}'

# rate = rospy.Rate(2)

# count = 0
# while not rospy.is_shutdown():
#     pub.publish(count)
#     count += 1
#     rate.sleep()
