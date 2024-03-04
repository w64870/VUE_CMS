<template>
    <div class="col-md-12 debug_info">
        <div>
            Wybrany kontekst: {{currentContext}}
            <br>
            Wybrana operacja: {{currentOperation}}
            <br>
        </div>
        <hr>
        <table v-if="screenData.db_info">
            <thead>
                <tr>
                    <th colspan="2">Baza danych</th>
                </tr>
            </thead>
            <tbody>
                <tr v-if="screenData.db_info.host">
                    <td>Host:</td>
                    <td>{{ screenData.db_info.host }}</td>
                </tr>
                <tr v-if="screenData.db_info.port">
                    <td>Port:</td>
                    <td>{{ screenData.db_info.port }}</td>
                </tr>
                <tr v-if="screenData.db_info.sid">
                    <td>SID:</td>
                    <td>{{ screenData.db_info.sid }}</td>
                </tr>
                <tr v-if="screenData.db_info.alias">
                    <td>Alias:</td>
                    <td>{{ screenData.db_info.alias }}</td>
                </tr>
                <tr v-if="screenData.db_info.username">
                    <td>Użytkownik:</td>
                    <td>{{ screenData.db_info.username }}</td>
                </tr>
            </tbody>
        </table>
        <hr>
        <table v-if="screenData.screen_elements_debug">
            <thead>
                <tr>
                    <th colspan="3">Zmienne</th>
                </tr>

                <tr>
                    <th>Zmienna</th>
                    <th>Wartość</th>
                    <th>Rodzaj</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(element, idx) in screenData.screen_elements_debug" :key="idx">
                    <td>{{ element.key }}</td>
                    <td>{{ element.value }}</td>
                    <td>{{ element.type }}</td>
                </tr>
                <tr v-for="(element, idx) in screenData.screen_elements_debug" :key="idx+'-time'">
                    <table
                        v-if="typeof element.executionTime !== 'undefined' && element.executionTime.length > 0"
                    >
                        <tr>
                            <th>czas wykonania zapytań {{ element.key }}:</th>
                        </tr>
                        <tr v-for="(exectime, idx) in element.executionTime" :key="idx">
                            <td>
                                <br>
                                {{ exectime.SQL }} => {{ exectime.czas }}
                                <br>
                            </td>
                        </tr>
                    </table>
                </tr>
            </tbody>
        </table>
        <hr>
        <table v-if="screenData.posted_screen_elements">
            <thead>
                <tr>
                    <th colspan="3">Zmienne wysłane z formularza:</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(element, key) in screenData.posted_screen_elements" :key="key">
                    <td>{{ key }}</td>
                    <td>{{ element }}</td>
                    <td>POST</td>
                </tr>
            </tbody>
        </table>
        <hr>
        <table>
            <thead>
                <tr>
                    <th colspan="2">Dodatkowe info:</th>
                </tr>
            </thead>
            <tbody>
                <tr v-if="screenData.active_element_name">
                    <td>aktywne_pole</td>
                    <td>{{ screenData.active_element_name }}</td>
                </tr>
                <tr v-if="screenData.error">
                    <td>blad</td>
                    <td>{{ screenData.error }}</td>
                </tr>
                <tr v-if="screenData.go_to_operation_screen">
                    <td>idz_do_ekr</td>
                    <td>{{ screenData.go_to_operation_screen['screen_name'] }}</td>
                </tr>
                <tr v-if="screenData.is_new_screen">
                    <td>Czy nowy ekran</td>
                    <td>{{ screenData.is_new_screen }}</td>
                </tr>
                <tr v-if="screenData.printer_ip">
                    <td>Adres IP drukarki</td>
                    <td>{{ screenData.printer_ip }}</td>
                </tr>
                <tr v-if="screenData.printer_port">
                    <td>Port drukarki</td>
                    <td>{{ screenData.printer_port }}</td>
                </tr>
            </tbody>
        </table>
        <hr>
        <table v-if="screenData.sql_queries">
            <thead>
                <tr>
                    <th>Zapytania SQL wysłane do bazy danych:</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(query, idx) in screenData.sql_queries" :key="idx">
                    <td>
                        <pre>{{ query }}</pre>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>


<script>
export default {
    name: "DebugInfo",
    props: ["screenData", "currentContext", "currentOperation"],
    data: function() {
        return {};
    },
    methods: {}
};
</script>


<style scoped>
</style>