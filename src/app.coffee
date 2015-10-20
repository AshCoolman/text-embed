module.exports = () ->
    
    fs = require 'fs'
    fsEx = require 'fs-extra'
    split = require 'split'
    through2 = require 'through2'
    
    { argv } = process
    [ engine, entry, inputFile, outputFile, cursor ] = argv

    fsEx.ensureFile outputFile, (err) ->
        throw err if err?

        inputStream = fs.createReadStream inputFile
        outputStream = fs.createWriteStream outputFile
        outputStream.on 'open', (fd) ->

            write = (chunk, encoding, next) ->
                chunk = chunk.toString()
                if chunk.startsWith cursor
                    embedLoc = chunk.split(cursor).join ''
                    [ fileName, lines ] = embedLoc.split '::lines:'
                    [ firstLine, lastLine ] = lines.split '-'
                    allLines = fs.readFileSync fileName, 'utf8'
                    embedLines = allLines.split('\n').splice firstLine - 1, lastLine - 1
                    @push embedLines.join('\n') + '\n'
                else
                    @push chunk + '\n'
                next()
                return null

            end = (done) ->
                done()
                return null
            
            textEmbed = through2 write, end
            
            inputStream
                .pipe split()
                .pipe textEmbed
                .pipe outputStream
