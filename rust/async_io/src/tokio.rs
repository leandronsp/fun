use tokio::fs::File;
use tokio::io::{self, AsyncBufReadExt, BufReader};
use tokio::select;

#[tokio::main]
async fn main() -> io::Result<()> {
    println!("Server started...");

    // Open FIFOs asynchronously
    let file0 = File::open("client0").await?;
    let file1 = File::open("client1").await?;

    let mut reader0 = BufReader::new(file0).lines();
    let mut reader1 = BufReader::new(file1).lines();

    loop {
        select! {
            line = reader0.next_line() => {
                match line {
                    Ok(Some(l)) => println!("Message from client0: {}", l),
                    Ok(None) => break, // EOF reached
                    Err(e) => eprintln!("Error reading from client0: {}", e),
                }
            },
            line = reader1.next_line() => {
                match line {
                    Ok(Some(l)) => println!("Message from client1: {}", l),
                    Ok(None) => break, // EOF reached
                    Err(e) => eprintln!("Error reading from client1: {}", e),
                }
            }
        }
    }

    Ok(())
}
