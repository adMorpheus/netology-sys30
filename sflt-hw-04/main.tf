terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token = var.yandex_cloud_token
  #секретные данные должны быть в сохранности!! Никогда не выкладывайте токен в публичный доступ.
  cloud_id  = "b1gjun127u4k4atukktq"
  folder_id = "b1g8b42ee52p3rnqlu9b"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet-1"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["172.24.8.0/24"]
}

resource "yandex_compute_instance" "vm" {
  count = 2
  name  = "vm${count.index}"
  resources {
    core_fraction = 5
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8jh8cfu4288rhk7ffu" #LEMP
      size = 5
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
}
resource "yandex_lb_target_group" "group-1" {
  name = "group-1"
  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address   = yandex_compute_instance.vm[0].network_interface.0.ip_address
  }
  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address   = yandex_compute_instance.vm[1].network_interface.0.ip_address
  }
}
resource "yandex_lb_network_load_balancer" "lb-1" {
  name = "lb-1"
  deletion_protection = false
  listener {
    name = "lis-lb1"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.group-1.id
    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}