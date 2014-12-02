-- XEP-0307: Unique Room Names for Multi-User Chat
local st = require "util.stanza";
local xmlns_unique = "http://jabber.org/protocol/muc#unique";

module:add_feature(xmlns_unique);


local adjective = {"autumn", "hidden", "bitter", "misty", "silent", "empty", "dry", "dark", "summer", "icy", "delicate", "quiet", "white", "cool", "spring", "winter", "patient", "twilight", "dawn", "crimson", "wispy", "weathered", "blue", "billowing", "broken", "cold", "damp", "falling", "frosty", "green", "long", "late", "lingering", "bold", "little", "morning", "muddy", "old", "red", "rough", "still", "small", "sparkling", "throbbing", "shy", "wandering", "withered", "wild", "black", "young", "holy", "solitary", "fragrant", "aged", "snowy", "proud", "floral", "restless", "divine", "polished", "ancient", "purple", "lively", "nameless"};

local noun = {"waterfall", "river", "breeze", "moon", "rain", "wind", "sea", "morning", "snow", "lake", "sunset", "pine", "shadow", "leaf", "dawn", "glitter", "forest", "hill", "cloud", "meadow", "sun", "glade", "bird", "brook", "butterfly", "bush", "dew", "dust", "field", "fire", "flower", "firefly", "feather", "grass", "haze", "mountain", "night", "pond", "darkness", "snowflake", "silence", "sound", "sky", "shape", "surf", "thunder", "violet", "water", "wildflower", "wave", "water", "resonance", "sun", "wood", "dream", "cherry", "tree", "fog", "frost", "voice", "paper", "frog", "smoke", "star"};

local verb = {"shakes", "drifts", "has-stopped", "struggles", "hears", "has-passed", "sleeps", "creeps", "flutters", "fades", "is-falling", "trickles", "murmurs", "warms", "hides", "jumps", "is-dreaming", "sleeps", "falls", "wanders", "waits", "has-risen", "stands", "dying", "is-drawing", "singing", "rises", "paints", "capturing", "flying", "lies", "picked-up", "gathers-in", "invites", "separates", "eats", "plants", "digs-into", "has-fallen", "weeping", "facing", "mourns", "tastes", "breaking", "shaking", "walks", "builds", "reveals", "piercing", "craves", "departing", "opens", "falling", "confronts", "keeps", "breaking", "is-floating", "settles", "reaches", "illuminates", "closes", "leaves", "explodes", "drawing"};

local prep = {"on", "beside", "in", "beneath", "of", "above", "under", "by", "over", "against", "near"};


function random(arr)
    local index = math.random(1, #arr);
    return arr[index];
end


module:hook("iq-get/host/http://jabber.org/protocol/muc#unique:unique", function (event)
    local origin, stanza = event.origin, event.stanza;

    -- This isn't guaranteed to be unique (even if we did check against existing rooms).
    -- We would need to integrate this with the room creation lock

    local name = {
        random(adjective),
        random(noun),
        random(verb),
        random(prep),
        random(adjective),
        random(noun)
    };

    origin.send(st.reply(stanza)
        :tag("unique", {xmlns = xmlns_unique})
        :text(table.concat(name, "-"))
    );

    return true;
end, -1);
