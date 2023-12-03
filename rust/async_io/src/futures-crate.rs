struct Song { 
    name: String,
}

async fn learn_song() -> Song { 
    println!("Learning song");
    Song { name: String::from("my song") }
}

async fn sing_song(song: Song) { 
    println!("Singing {}", song.name);
}

async fn dance() { 
    println!("Dancing");
}

async fn learn_and_sing() { 
    let song = learn_song().await;
    sing_song(song).await;
}

async fn async_runtime() {
    let f1 = learn_and_sing();
    let f2 = dance();
    futures::join!(f1, f2);

}

fn main() {
    futures::executor::block_on(async_runtime());
}
