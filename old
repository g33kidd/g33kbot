package main

import (
    "sync"
	"io"
    "fmt"
	"net/http"
	"github.com/nareix/joy4/format"
	"github.com/nareix/joy4/av/avutil"
	"github.com/nareix/joy4/av/pubsub"
	"github.com/nareix/joy4/format/rtmp"
	"github.com/nareix/joy4/format/flv"
)

// ffmpeg -re -i movie.flv -c copy -f flv rtmp://localhost/movie
// ffmpeg -f avfoundation -i "0:0" .... -f flv rtmp://localhost/screen
// ffplay http://localhost:8089/movie
// ffplay http://localhost:8089/screen
//
// Maybe look into WebRTC or MessagePack or red5...
// go-webrtc doesn't support video/audio

// The channel type for multiple channel usage ¯\_(ツ)_/¯
type Channel struct {
    queue *pubsub.Queue
}

func init() {
    fmt.Printf("Initializing...\n")
    format.RegisterAll()
}

type writeFlusher struct {
    httpflusher http.Flusher
    io.Writer
}

func (self writeFlusher) Flush() error {
    fmt.Printf("Flushing...\n")
    self.httpflusher.Flush()
    return nil
}

func main() {

    fmt.Printf("Main...\n")

    // Setup some variables
    server      := &rtmp.Server{}
    rwmutex     := &sync.RWMutex{}
    channels    := map[string]*Channel{}

    // Handles plays
    server.HandlePlay = func(conn *rtmp.Conn) {
        fmt.Printf("Playing channel [%s]", conn.URL.Path)

        rwmutex.RLock()
        channel := channels[conn.URL.Path]
        rwmutex.RUnlock()

        if channel != nil {
            cursor := channel.queue.Latest()
            avutil.CopyFile(conn, cursor)
        } else {
            fmt.Print("channel is nil in HandlePlay")
        }
    }

    // Handles publishing when something comes into the stream ¯\_(ツ)_/¯
    // TODO: Read the docs on this more...
    server.HandlePublish = func(conn *rtmp.Conn) {
        streams, _ := conn.Streams()

        rwmutex.Lock()

        // The current channel for this stream
        channel := channels[conn.URL.Path]
        if channel == nil {
            channel = &Channel{}
            channel.queue = pubsub.NewQueue()
            channel.queue.WriteHeader(streams)
            channels[conn.URL.Path] = channel
            fmt.Printf("Setting channel [%s]\n", conn.URL.Path)
        } else {
            channel = nil
        }

        rwmutex.Unlock()

        if channel == nil {
            return
        }

        // Copies the packets that are currently being published.
        avutil.CopyPackets(channel.queue, conn)

        // ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯
        // NOTE delete teh channel, but whys?
        // rwmutex.Lock()
        // delete(channels, conn.URL.Path)
        // rwmutex.Unlock()

        channel.queue.Close()
    }

    // NOTE: We probably really don't need this.
    // TODO: Just read the stream as rtmp://
    // NOTE: Keeps getting invalid data ¯\_(ツ)_/¯
    // TODO: Look at updating the joy4 package if it needs updating
    // HTTP Handler for clients and plays for the server
    http.HandleFunc("/", func(res http.ResponseWriter, req *http.Request) {
        rwmutex.RLock()
        channel := channels[req.URL.Path]
        rwmutex.RUnlock()

        fmt.Printf("Handling http request\n")
        fmt.Printf("%+v\n", channel)

        if channel != nil {
            fmt.Printf("channel is not nil..\n")
            res.Header().Set("Content-Type", "video/x-flv")
            res.Header().Set("Transfer-Encoding", "chunked")
            res.Header().Set("Access-Control-Allow-Origin", "*")
            res.WriteHeader(200)

            flusher := res.(http.Flusher)
            flusher.Flush()

            muxer   := flv.NewMuxerWriteFlusher(writeFlusher{httpflusher: flusher, Writer: res})
            cursor  := channel.queue.Latest()

            avutil.CopyFile(muxer, cursor)
        } else {
            http.NotFound(res, req)
        }
    })

    fmt.Printf("starting http and rtmp server...\n")
    go http.ListenAndServe(":8089", nil)
    server.ListenAndServe()

}
