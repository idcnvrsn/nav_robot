import rospy

# from std_msgs.msg import Int32
from geometry_msgs.msg import PoseStamped
from actionlib_msgs.msg import GoalStatusArray
import random
import math

class Controller(object):
    def __init__(self):
        rospy.init_node('controller')
        self.pub_goal = rospy.Publisher('move_base_simple/goal', PoseStamped, queue_size=1)
        self.goal_set=False
        self.goal=self.get_goal(0.0,0.0, 0)

        # self.goals=[[-1.0,1.6],[0.0,1.5],[-1.0,-0.5],[0.0,-0.5],[-1.0,-2.0],[0.0,-2.0],[2.0,-0.5],[-2.0,-0.5]]
        # self.goals=[[2.0,1.0],[2.0,-1.0]]
        self.goals=[]
        for y in [-1.0, 0.0, 1.0, 2.0]:
            for x in [0.5, 1.5, 2.5]:
                self.goals.append([x,y])

        sub = rospy.Subscriber('/move_base/status', GoalStatusArray, self.callback)
        rospy.spin()

    def get_goal(self, x, y, rad):
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

    def callback(self, msg):

        if len(msg.status_list) == 0:
            status = None
        else:
            status = msg.status_list[0].status
        if (status == 3) or (status == 4) or (status == None):
            if self.goal_set==False:
                idx=random.randint(0, len(self.goals))
                x=self.goals[idx][0]
                y=self.goals[idx][1]
                self.goal=self.get_goal(x, y, math.atan2(y-0.5,x-2.0))
                self.goal_set=True
            self.pub_goal.publish(self.goal)
        else:
            self.goal_set=False

        print(status, self.goal)

def main():
    controller=Controller()

if __name__ == '__main__':
    main()
