module "vpc" {
    source = "./vpc"
    vpc_cidr = "10.0.0.0/16"
  
}
module "AZ" {
    source = "./AZ"
}
module "subnet" {
    source = "./subnet"
    vpc_id = module.vpc.vpc_id
    cidr_subnet_public_AZ1 = "10.0.0.0/24"
    cidr_subnet_private_AZ1 = "10.0.1.0/24"
    cidr_subnet_private_AZ2 = "10.0.2.0/24"
    cidr_subnet_public_AZ2 = "10.0.3.0/24"
    AZ1 = module.AZ.az_names[0]
    AZ2 = module.AZ.az_names[1]
}

module "routes" {
    source = "./routes"
    id_subnet_public_AZ1 = module.subnet.subnet_public_AZ1_id
    id_subnet_public_AZ2 = module.subnet.subnet_public_AZ2_id
    vpc_id = module.vpc.vpc_id
  
}
module "SG" {
    source = "./SecurittGroup"
    vpc_id = module.vpc.vpc_id
  
}
module "elb" {
    source = "./elb"
    vpc_id = module.vpc.vpc_id
    subnet_private_AZ1_id = module.subnet.subnet_private_AZ1_id
    subnet_private_AZ2_id = module.subnet.subnet_private_AZ2_id
    subnet_public_AZ1_id = module.subnet.subnet_public_AZ1_id
    subnet_public_AZ2_id = module.subnet.subnet_public_AZ2_id
    private_SG_id = module.SG.private_SG_id
    public_SG_id = module.SG.public_SG_id
  
}
module "EC2" {
    source = "./EC2"
    subnet_private_AZ1_id = module.subnet.subnet_private_AZ1_id
    subnet_private_AZ2_id = module.subnet.subnet_private_AZ2_id
    subnet_public_AZ1_id = module.subnet.subnet_public_AZ1_id
    subnet_public_AZ2_id = module.subnet.subnet_public_AZ2_id
    private_SG_id = module.SG.private_SG_id
    public_SG_id = module.SG.public_SG_id
    public_target_group_arn = module.elb.public_target_group_arn
    private_target_group_arn = module.elb.private_target_group_arn
}