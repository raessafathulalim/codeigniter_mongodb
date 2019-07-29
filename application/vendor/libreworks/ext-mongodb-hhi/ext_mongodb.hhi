<?hh // decl

/**
 * This is the public API of the new MongoDB driver for use with the Hack type
 * checker. This file should never be included.
 */
namespace MongoDB\BSON;

interface Type
{
}

interface Serializable extends Type
{
	public function bsonSerialize() : mixed;
}

interface Unserializable
{
	public function bsonUnserialize(array $data) : void;
}

interface Persistable extends Serializable, Unserializable
{
}

namespace MongoDB\Driver\Monitoring;

abstract class _CommandEvent
{
	public function getCommandName() : string {}

	public function getServer() : \MongoDB\Driver\Server {}

	public function getOperationId() : string {}

	public function getRequestId() : string {}
}

abstract class _CommandResultEvent extends _CommandEvent
{
	public function getDurationMicros() : int {}
}

final class CommandStartedEvent extends _CommandEvent
{
	public function getCommand() : mixed {}

	public function getDatabaseName() : string {}
}

final class CommandSucceededEvent extends _CommandResultEvent
{
	public function getReply() : mixed {}
}

final class CommandFailedEvent extends _CommandResultEvent
{
	public function getError() : \MongoDB\Driver\Exception\Exception {}
}

interface Subscriber {}

interface CommandSubscriber extends Subscriber
{
	public function commandStarted( \MongoDB\Driver\Monitoring\CommandStartedEvent $event );
	public function commandSucceeded( \MongoDB\Driver\Monitoring\CommandSucceededEvent $event );
	public function commandFailed( \MongoDB\Driver\Monitoring\CommandFailedEvent $event );
}

namespace MongoDB\Driver;

final class WriteConcernError {

	public function getCode() : int {}

	public function getMessage() : string { }

	public function getInfo() : ?array { }

	public function __debugInfo() : array { }
}

final class WriteError {

	public function getMessage() {}

	public function getCode() { }

	public function getIndex() { }

	public function getInfo() { }

	public function __debugInfo() { }
}

final class WriteResult {

	public function __wakeup() { }

	public function getInsertedCount() {  }
	public function getMatchedCount()  { }
	public function getModifiedCount() {  }
	public function getDeletedCount()  { }
	public function getUpsertedCount() {  }

	public function getServer() : Server;

	public function getUpsertedIds(): array { }

	public function getWriteConcernError() { }

	public function getWriteErrors(): array { }

	public function isAcknowledged() : bool;

	public function __debugInfo() : array { }
}

final class Manager {

	public function __construct(string $dsn = "", array $options = array(), array $driverOptions = array());

	public function __debugInfo() : array;

	public function executeCommand(string $db, Command $command, ?ReadPreference $readPreference = null): Cursor;

	public function executeQuery(string $namespace, Query $query, ?ReadPreference $readPreference = null): Cursor;

	public function executeBulkWrite(string $namespace, BulkWrite $bulk, ?WriteConcern $writeConcern = null): WriteResult;

	public function getServers(): array;

	public function getReadConcern() : ReadConcern;

	public function getReadPreference() : ReadPreference;

	public function getWriteConcern() : WriteConcern;

	public function __wakeup() : void;

	public function selectServer(ReadPreference $readPreference): Server;

	public function addSubscriber( Monitoring\Subscriber $subscriber ) : void;

	public function removeSubscriber( Monitoring\Subscriber $subscriber ) : void;
}

class Utils {
	const ERROR_INVALID_ARGUMENT  = 1;
	const ERROR_RUNTIME           = 2;
	const ERROR_MONGOC_FAILED     = 3;
	const ERROR_WRITE_FAILED      = 4;
	const ERROR_CONNECTION_FAILED = 5;

	static public function throwHippoException($domain, $message) { }

	static public function mustBeArrayOrObject(string $name, mixed $value, string $context = '') { }
}

final class CursorId {
	public function __debugInfo() : array;

	public function __toString() : string;
}

final class Cursor<T> implements \Traversable<T>, \Iterator<T> {
	public function __debugInfo() : array;

	public function getId() : CursorId;

	public function getServer() : Server;

	public function isDead() : bool;

	public function current(): T;

	public function key(): int;

	public function next(): void;

	public function rewind(): void;

	public function valid(): bool;

	public function toArray(): array<T>;

	public function setTypeMap(array<string,mixed> $typemap): void;
}

final class Command {

	public function __construct(mixed $command) { }

	public function __debugInfo(): array { }
}

final class Query {

	public function __construct(mixed $filter, array $options = array()) { }

	public function __debugInfo() : array { }
}

final class BulkWrite implements \Countable {

	public function __construct(?array $bulkWriteOptions = array());

	public function insert(mixed $document) : mixed;

	public function update(mixed $query, mixed $update, ?array $options = []) : void;

	public function delete(mixed $query, ?array $options = []) : void;

	public function count() : int;

	public function __debugInfo() : array;
}

final class ReadConcern implements \MongoDB\BSON\Serializable {

	public function __construct(?string $level = NULL) : void;

	public function getLevel() : mixed;

	public function __debugInfo() : array;

	public function bsonSerialize() : mixed;
}

final class ReadPreference implements \MongoDB\BSON\Serializable {
	const RP_PRIMARY = 1;
	const RP_PRIMARY_PREFERRED = 5;
	const RP_SECONDARY = 2;
	const RP_SECONDARY_PREFERRED = 6;
	const RP_NEAREST = 10;

	public function __construct(int $readPreference, ?array $tagSets = null, ?array $options = [] ) { }

	public function getMode() : int;

	public function getTagSets() : array;

	public function getMaxStalenessSeconds() : int;

	public function __debugInfo() : array;

	public function bsonSerialize() : mixed;
}

final class Server {

	public function __debugInfo() : array;

	public function getHost(): string;

	final public function getInfo(): array;

	public function getLatency() : int;

	public function getPort(): int;

	public function getTags() : array;

	public function getType(): int;

	public function isPrimary() : bool;

	public function isSecondary() : bool;

	public function isArbiter() : bool;

	public function isHidden() : bool;

	public function isPassive() : bool;

	public function executeBulkWrite(string $namespace, BulkWrite $bulk, ?WriteConcern $writeConcern = null): WriteResult;

	public function executeCommand(string $db, Command $command, ?ReadPreference $readPreference = null): Cursor;

	public function executeQuery(string $namespace, Query $query, ?ReadPreference $readPreference = null): Cursor;
}

final class WriteConcern implements \MongoDB\BSON\Serializable {
	const MAJORITY = "majority";

	public function __construct(mixed $w, ?int $wtimeout = 0, ?bool $journal = NULL);

	public function getJournal() : mixed;

	public function getW() : mixed;

	public function getWtimeout() : int;

	public function __debugInfo() : array;

	public function bsonSerialize() : mixed;
}


namespace MongoDB\Driver\Exception;

interface Exception {}

class ConnectionException extends RuntimeException {}

class AuthenticationException extends ConnectionException {}
class ConnectionTimeoutException extends ConnectionException {}
class ExecutionTimeoutException extends RuntimeException {}
class InvalidArgumentException extends \InvalidArgumentException implements Exception {}
class LogicException extends \LogicException implements Exception {}
class RuntimeException extends \RuntimeException implements Exception {}
class SSLConnectionException extends ConnectionException {}
class UnexpectedValueException extends \UnexpectedValueException implements Exception {}
class BulkWriteException extends WriteException {}

abstract class WriteException extends RuntimeException
{
	final public function getWriteResult() : \MongoDB\Driver\WriteResult { }
}



namespace MongoDB\BSON;

interface TypeWrapper
{
	static public function createFromBSONType(\MongoDB\BSON\Type $type) : \MongoDB\BSON\TypeWrapper;
	public function toBSONType();
}

interface BinaryInterface
{
	public function getType() : int;
	public function getData() : string;
	public function __toString() : string;
}

interface Decimal128Interface
{
	public function __toString() : string;
}

interface JavascriptInterface
{
	public function getCode() : string;
	public function getScope() : mixed;
	public function __toString() : string;
}

interface MaxKeyInterface
{
}

interface MinKeyInterface
{
}

interface ObjectIDInterface
{
	public function getTimestamp() : int;
	public function __toString() : string;
}

interface RegexInterface
{
	public function getPattern() : string;
	public function getFlags() : string;
	public function __toString() : string;
}

interface TimestampInterface
{
	public function __toString() : string;
}

interface UTCDateTimeInterface
{
	public function toDateTime() : \DateTime;
	public function __toString() : string;
}

function fromPHP(mixed $data) : string;

function fromJson(string $data) : mixed;

function toPHP(string $data, ?array $typemap = array()) : mixed;

function toJson(string $data) : mixed;

trait DenySerialization
{
	public function serialize() : string { }

	public function unserialize(mixed $data) : void { }
}

final class Binary implements Type, \Serializable, \JsonSerializable, BinaryInterface
{
	const int TYPE_GENERIC = 0;
	const int TYPE_FUNCTION = 1;
	const int TYPE_OLD_BINARY = 2;
	const int TYPE_OLD_UUID = 3;
	const int TYPE_UUID = 4;
	const int TYPE_MD5 = 5;
	const int TYPE_USER_DEFINED = 128;

	public function serialize() : string { }

	public function jsonSerialize() : mixed { }

	public function unserialize(mixed $serialized) : void { }

	public function __construct(string $data, int $type) { }

	static public function __set_state(array $state) { }

	public function getType() : int { }

	public function getData() : string { }

	public function __toString() : string { }

	public function __debugInfo() : array;
}

final class Decimal128 implements Type, \Serializable, \JsonSerializable, Decimal128Interface
{
	public function serialize() : string { }

	public function jsonSerialize() : mixed { }

	public function unserialize(mixed $serialized) : void { }

	public function __construct(string $decimal) { }

	static public function __set_state(array $state) { }

	public function __toString() : string { }

	public function __debugInfo() : array { }
}

final class Javascript implements Type, \Serializable, \JsonSerializable, JavascriptInterface
{
	public function serialize() : string { }

	public function jsonSerialize() : mixed { }

	public function unserialize(mixed $serialized) : void { }

	public function __construct(string $code, mixed $scope = NULL) { }

	static public function __set_state(array $state) { }

	public function __debugInfo() : array { }

	public function getCode() : string { }

	public function getScope() : mixed { }

	public function __toString() : string { }
}

final class MaxKey implements Type, \Serializable, \JsonSerializable, MaxKeyInterface
{
	public function serialize() : string { }

	public function jsonSerialize() : mixed { }

	public function unserialize(mixed $serialized) : void { }

	static public function __set_state(array $state) { }
}

final class MinKey implements Type, \Serializable, \JsonSerializable, MinKeyInterface
{
	public function serialize() : string { }

	public function jsonSerialize() : mixed { }

	public function unserialize(mixed $serialized) : void { }

	static public function __set_state(array $state) { }
}

final class ObjectID implements Type, \Serializable, \JsonSerializable, ObjectIDInterface
{
	public function serialize() : string { }

	public function jsonSerialize() : mixed { }

	public function unserialize(mixed $serialized) : void { }

	public function __construct(?string $objectId = null) { }

	static public function __set_state(array $state) { }

	public function __toString() : string { }

	public function __debugInfo() : array { }

	public function getTimestamp() : int { }
}

final class Regex implements Type, \Serializable, \JsonSerializable, RegexInterface
{
	public function serialize() : string { }

	public function jsonSerialize() : mixed { }

	public function unserialize(mixed $serialized) : void { }

	public function __construct(string $pattern, string $flags = '') { }

	static public function __set_state(array $state) { }

	public function getPattern() : string { }

	public function getFlags() : string { }

	public function __toString() : string { }

	public function __debugInfo() : array { }
}

final class Timestamp implements Type, \Serializable, \JsonSerializable, TimestampInterface
{
	public function serialize() : string { }

	public function jsonSerialize() : mixed { }

	public function unserialize(mixed $serialized) : void { }

	public function __construct(mixed $increment, mixed $timestamp) { }

	static public function __set_state(array $state) { }

	public function __toString() : string { }

	public function __debugInfo() : array { }
}

final class UTCDateTime implements Type, \Serializable, \JsonSerializable, UTCDateTimeInterface
{
	public function serialize() : string { }

	public function jsonSerialize() : mixed { }

	public function unserialize(mixed $serialized) : void { }

	public function __construct(mixed $milliseconds = NULL) { }

	static public function __set_state(array $state) { }

	public function __toString() : string { }

	public function toDateTime() : \DateTime { }

	public function __debugInfo() : array { }
}
