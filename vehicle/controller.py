#! /usr/bin/env python3

from geometry_msgs.msg import PoseStamped
from nav2_simple_commander.robot_navigator import BasicNavigator, TaskResult
import rclpy
from rclpy.duration import Duration
import random

class RandomNavigator:
    def __init__(self):
        rclpy.init()
        self.navigator = BasicNavigator()

        # Set our demo's initial pose
        initial_pose = PoseStamped()
        initial_pose.header.frame_id = 'map'
        initial_pose.header.stamp = self.navigator.get_clock().now().to_msg()
        initial_pose.pose.position.x = 0.0
        initial_pose.pose.position.y = 0.0
        initial_pose.pose.orientation.z = 0.0
        initial_pose.pose.orientation.w = 1.0
        self.navigator.setInitialPose(initial_pose)

        self.navigator.waitUntilNav2Active()

    def run(self):
        while True:
            # Generate random goal pose
            goal_pose = self.generate_random_pose()

            self.navigator.goToPose(goal_pose)

            while not self.navigator.isTaskComplete():
                # Implement obstacle avoidance here if needed

                # Do something with the feedback
                feedback = self.navigator.getFeedback()
                if feedback:
                    print(
                        'Estimated time of arrival: '
                        + '{0:.0f}'.format(
                            Duration.from_msg(feedback.estimated_time_remaining).nanoseconds
                            / 1e9
                        )
                        + ' seconds.'
                    )

                    # Some navigation timeout to demo cancellation
                    if Duration.from_msg(feedback.navigation_time) > Duration(seconds=600.0):
                        self.navigator.cancelTask()

                    # Some navigation request change to demo preemption
                    if Duration.from_msg(feedback.navigation_time) > Duration(seconds=18.0):
                        goal_pose = self.generate_random_pose()
                        self.navigator.goToPose(goal_pose)

            # Do something depending on the return code
            result = self.navigator.getResult()
            if result == TaskResult.SUCCEEDED:
                print('Goal succeeded!')
            elif result == TaskResult.CANCELED:
                print('Goal was canceled!')
            elif result == TaskResult.FAILED:
                print('Goal failed!')
            else:
                print('Goal has an invalid return status!')

    def generate_random_pose(self):
        goal_pose = PoseStamped()
        goal_pose.header.frame_id = 'map'
        goal_pose.header.stamp = self.navigator.get_clock().now().to_msg()
        goal_pose.pose.position.x = random.choice([0.5, 1.5, 2.5, 3.5])#[0.0, 1.0, 2.0, 3.0])
        goal_pose.pose.position.y = random.choice([-1.0, 0.0, 1.0, 2.0])#[0.0, 1.0])
        goal_pose.pose.orientation.w = 1.0
        return goal_pose

    def shutdown(self):
        self.navigator.lifecycleShutdown()
        rclpy.shutdown()

if __name__ == '__main__':
    navigator = RandomNavigator()
    try:
        navigator.run()
    finally:
        navigator.shutdown()
