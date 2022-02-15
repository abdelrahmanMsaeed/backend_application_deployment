resource "google_compute_instance" "VM" {
  name         = var.vm_name
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

    depends_on = [
    # google_service_account.sa_vm,
    google_compute_subnetwork.public_subnet
  ]
  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.public_subnet.id
  }

 metadata_startup_script = <<SCRIPT
    sudo adduser --disabled-password --gecos ""  ansible ; 
    usermod -aG sudo ansible ;
    sudo chown -R ansible:ansible /home/ansible/ ;
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    sudo apt-get update ; 
    sudo apt-get -y install ansible ;
    runuser -l ansible -c 'ansible-galaxy collection install kubernetes.core' ;
    runuser -l ansible -c 'ansible-galaxy collection install cloud.common' ;
    sudo apt update ;
    sudo apt -y install python3-pip ;
    sudo pip install kubernetes ;
    gsutil -m cp -r gs://test-graduation-project/* /home/ansible  ;   
    sudo runuser -l ansible -c 'ansible-playbook /home/ansible/project_role/test.yml' ;
    
 SCRIPT

 
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.vm_service_account.email
    scopes = ["cloud-platform"]
  }
}

