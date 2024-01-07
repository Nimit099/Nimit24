trigger Lead on Lead (after insert) {
    Leadhandler.changerating(Trigger.new);
}