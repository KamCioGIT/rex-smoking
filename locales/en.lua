local Translations = {

    client = {
        lang_1 = 'Animation Failed to Load',
    },

    server = {
        lang_1 = 'No Matches!',
    },

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- Lang:t('client.lang_1')
-- Lang:t('server.lang_1')
