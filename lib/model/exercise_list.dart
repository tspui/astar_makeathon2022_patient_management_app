class Exercise {
  final String title;
  final String subtitle;
  final String time;
  final String imagePath;
  final String videoPath;
  final String detailExercise;
  final String bodyArea;
  final String movementType;
  Exercise(this.title, this.subtitle, this.time, this.imagePath, this.videoPath,
      this.detailExercise, this.bodyArea, this.movementType);

  static List<Exercise> getExercises() {
    List<Exercise> items = <Exercise>[];
    items.add(Exercise(
        "Seated Thoracic Extension with Shoulder Flex",
        'Repeat 5 times',
        'Start',
        'seated_thoracic.jpg',
        'seated_thoracic.mp4',
        'Stand or sit. Raise arms to the sides while breathing in. Bring arms back to side while breathing out. Repeat 5 times.',
        'Cardio- and Respiratory System, Other Areas, Trunk and Back',
        'Extension'));
    items.add(Exercise(
        "Middle Scalene Stretch",
        'Repeat 5 times',
        'Start',
        'middle_scalene1.jpg',
        'middle_scalene.mp4',
        'Sit up with back straight. Use affected hand to hold on to seat. Reach for affected ear over head with good hand. Bend head down towards good shoulder using affected hand. Notice stretch at afffected neck. Repeat 5 times',
        'Neck, Neck Lateral Flexors',
        'Lateral Flexion'));
    items.add(Exercise(
        "Active Neck Lateral Flexion Stretch",
        'Repeat 5 times',
        'Start',
        'neck.jpg',
        'neck_right.mp4',
        'Stand with both arms straightened by the side. Stretch out affected arm, with fingers stretched towards floor. Keep shoulder lowered towards floor. Slowly tilt head to good. Hold postion for 5 seconds. Repeat 5 times.',
        'Neck, Neck Lateral Flexors',
        'Lateral Flexion'));
    items.add(Exercise(
        "Seated Trunk Lateral Flexion and Rotation",
        'Repeat 3-5 times',
        'Start',
        'seatedTrunk.jpg',
        'seatedTrunk.mp4',
        'Sit on chair with both arms across chest. Hands on opposite shoulders. Rotate upper body to the left side. Repeat for right side. Breath out while rotating. Let eyes follow movement. Repeat 5 times.',
        'Thoraci Spine, Trunk and Back, Trunk Flexors, Trunk Rotators',
        'Extension, Lateral Flexion, Rotation and Circumduction'));

    items.add(Exercise(
        "Standing Straight Leg Raise",
        'Repeat 5 times',
        'Start',
        'hip.jpg',
        'hip.mp4',
        'Stand with both legs straightened. Lift affected leg, keeping affected knee straightened. Repeats 5 times.',
        'Hip, Hip Flexors, Knee, Knee Extensors',
        'Lower Extremities'));

    return items;
  }
}
