docker run --name mcgiprodtools-pg -e POSTGRES_USER=root -e POSTGRES_PASSWORD=ABC12abc -p 5432:5432 -v /data:/var/lib/postgresql/data -d postgres