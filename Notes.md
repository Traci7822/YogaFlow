Models:
  User
    has_many :sequences
    has_many :poses, through: :sequences

    -Validate credentials
    -sign up/log in/log out/Omniauth
  Sequence
    has_many :sequence_poses
    has_many :poses, though: :sequence_poses
    belongs_to :user
  Pose
    has_many :sequence_poses
    has_many :sequences, through: :sequence_poses

Controllers:
  Users
  Sequences
  Poses

Tables:
    Users
      username
      password
    Sequences
      title
      length
      style (checkboxes)
      focus (checkboxes)
      difficulty (drop down rating)
    Poses
      name
      description
    Sequence_poses
      sequence id
      pose id
      repeated? t/f
        user creates a sequence of poses and then when the sequence is created
        it checks if there’s more than one instance of a pose and if so, sets
        repeated to true
        (first answer: http://stackoverflow.com/questions/315792/how-to-avoid-duplicates-in-a-has-many-through-relationship)

User type? Creator/User

Scope method:
  most_popular_pose
    Pose.most_used, Post.by_user
    Pose.most_used.by_user(@user)

Nested Form
  sequence[pose_attributes][0][name]
  sequence[pose_attributes][0][description]
  pose_attributes=
    build Pose model through this macro
      -find_or_create_by name
      -create row in sequence_poses w/ sequence id, pose id, and description

RESTful Routes:
  sequences/:id/poses/new

Validation Errors:
  fields_with_errors class
  show in view
