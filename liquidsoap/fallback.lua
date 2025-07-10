function fallback(source)
  return function()
    if source:is_empty() then
      return request.create("/var/bbradio/emergency.mp3")
    else
      return source
    end
  end
end
