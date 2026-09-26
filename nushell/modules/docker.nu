def dps [] {
    docker ps
}

def dcu [] {
    docker compose up -d
}

def dcd [] {
    docker compose down
}


def dlogs [container:string] {
    docker logs -f $container
}
