package blocks

class ErrorController {

    def index() {
        if (  grails.util.Environment.PRODUCTION == grails.util.Environment.getCurrent() ) {
            // Production: show a nice error message
            render(view:'production')
        } else {
            // Not it production? show an ugly, developer-focused error message
            render(view:'development')
        }
    }
}