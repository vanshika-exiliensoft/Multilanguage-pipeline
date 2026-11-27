

# ECS cluster
resource "aws_ecs_cluster" "app" {
  name = "multilanguage-cluster"

  tags = {
    Project   = "Multilanguage-Pipeline"
    ManagedBy = "Terraform"
  }
}

# CloudWatch logs
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/multilanguage-app"
  retention_in_days = 7
}

# ECS task execution role
resource "aws_iam_role" "ecs_execution" {
  name = "multilanguage-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Allow ECS to pull ECR images and publish logs
resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role = aws_iam_role.ecs_execution.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Security group
resource "aws_security_group" "ecs_app" {
  name        = "multilanguage-ecs-sg"
  description = "Allow Node.js application traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Node.js application"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "Multilanguage-Pipeline"
  }
}

# Fargate task definition
resource "aws_ecs_task_definition" "app" {
  family                   = "multilanguage-nodejs"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name      = "nodejs-app"
      image     = "${aws_ecr_repository.app.repository_url}:${var.image_tag}"
      essential = true

      portMappings = [{
        containerPort = 8080
        hostPort      = 8080
        protocol      = "tcp"
      }]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.app.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution
  ]
}

# ECS Fargate service
resource "aws_ecs_service" "app" {
  name            = "multilanguage-nodejs-service"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.public[*].id
    security_groups  = [aws_security_group.ecs_app.id]
    assign_public_ip = true
  }

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution
  ]

  tags = {
    Project = "Multilanguage-Pipeline"
  }
}
